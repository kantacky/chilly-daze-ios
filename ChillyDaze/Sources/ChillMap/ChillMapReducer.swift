import ComposableArchitecture
import CloudStorageClient
import GatewayClient
import LocationManager
import _MapKit_SwiftUI
import Models
import SwiftUI

@Reducer
public struct ChillMapReducer {
    // MARK: - State
    public struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        @BindingState var mapCameraPosition: MapCameraPosition
        var chills: DataStatus<[Chill]>
        var scene: Scene

        public init() {
            self.mapCameraPosition = .camera(
                .init(
                    centerCoordinate: .init(latitude: 0, longitude: 0),
                    distance: 3000
                )
            )
            self.chills = .initialized
            self.scene = .ready
        }

        enum Scene: Equatable {
            case ready
            case inSession(Chill)
            case ending(Chill)
            case welcomeBack(Chill)
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case alert(PresentationAction<Alert>)
        case binding(BindingAction<State>)
        case onAppear
        case getChillsResult(Result<[Chill], Error>)
        case onChangeCoordinate(CLLocationCoordinate2D)
        case onStartButtonTapped
        case startChillResult(Result<Chill, Error>)
        case onStopButtonTapped
        case onEndChillAlertCancelButtonTapped
        case onEndChillAlertStopButtonTapped
        case onCameraButtonTapped
        case welcomeBackOkButtonTapped(Shot)
        case savePhotoResult(Result<Photo, Error>)
        case stopChillResult(Result<Chill, Error>)

        public enum Alert: Equatable {}
    }

    // MARK: - Dependencies
    @Dependency(\.cloudStorageClient)
    private var cloudStorageClient
    @Dependency(\.gatewayClient)
    private var gatewayClient
    @Dependency(\.locationManager)
    private var locationManager

    public enum CancelID {
        case coordinateSubscription
    }

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce {
            state,
            action in
            switch action {
            case .alert:
                return .none

            case .binding:
                return .none

            case .onAppear:
                do {
                    try self.locationManager.startUpdatingLocation()

                    let coordinate = try self.locationManager.getCurrentLocation()

                    state.mapCameraPosition = .camera(
                        .init(
                            centerCoordinate: coordinate,
                            distance: state.mapCameraPosition.camera?.distance ?? 3000
                        )
                    )
                } catch {
                    state.alert = .init(title: .init(error.localizedDescription))
                    return .none
                }

                state.chills = .loading

                return .merge(
                    .run { send in
                        await send(.getChillsResult(Result {
                            try await self.gatewayClient.getChills()
                        }))
                    },
                    .run { send in
                        for await value in self.locationManager.getLocationStream() {
                            Task.detached { @MainActor in
                                send(.onChangeCoordinate(value))
                            }
                        }
                    }
                        .cancellable(id: CancelID.coordinateSubscription)
                )

            case let .getChillsResult(.success(chills)):
                state.chills = .loaded(chills)
                return .none

            case let .getChillsResult(.failure(error)):
                state.alert = .init(title: .init(error.localizedDescription))
                state.chills = .initialized
                return .none

            case let .onChangeCoordinate(coordinate):
                switch state.scene {
                case var .inSession(chill):
                    let tracePoint: TracePoint = .init(timestamp: .now, coordinate: coordinate)
                    chill.traces.append(tracePoint)
                    state.scene = .inSession(chill)

                default:
                    break
                }
                return .none

            case .onStartButtonTapped:
                return .run { send in
                    await send(
                        .startChillResult(Result {
                            let coordinate: CLLocationCoordinate2D = try self.locationManager.getCurrentLocation()

                            return try await self.gatewayClient.startChill(
                                .now,
                                coordinate.latitude,
                                coordinate.longitude
                            )
                        })
                    )
                }

            case let .startChillResult(.success(chill)):
                switch state.scene {
                case .ready:
                    state.scene = .inSession(chill)

                default:
                    break
                }
                return .none

            case let .startChillResult(.failure(error)):
                state.alert = .init(title: { .init(error.localizedDescription) })
                return .none

            case .onStopButtonTapped:
                switch state.scene {
                case let .inSession(chill):
                    state.scene = .ending(chill)

                default:
                    break
                }
                return .none

            case .onEndChillAlertCancelButtonTapped:
                switch state.scene {
                case let .ending(chill):
                    state.scene = .inSession(chill)

                default:
                    break
                }
                return .none

            case .onEndChillAlertStopButtonTapped:
                switch state.scene {
                case var .ending(chill):
                    guard let coordinate: CLLocationCoordinate2D = try? self.locationManager.getCurrentLocation() else {
                        return .none
                    }
                    let tracePoint: TracePoint = .init(timestamp: .now, coordinate: coordinate)
                    chill.traces.append(tracePoint)
                    state.scene = .welcomeBack(chill)

                default:
                    break
                }
                return .none

            case .onCameraButtonTapped:
                return .none

            case let .welcomeBackOkButtonTapped(shot):
                switch state.scene {
                case let .welcomeBack(chill):
                    return .run { send in
                        await send(.savePhotoResult(Result {
                            let data = shot.image.jpegData(compressionQuality: 0.5)
                            let url = try await self.cloudStorageClient.uploadData(data, "\(UUID().uuidString).jpg")
                            let photo: Photo = .init(timestamp: shot.timestamp, url: url)
                            return photo
                        }))
                    }

                default:
                    break
                }
                return .none

            case let .savePhotoResult(.success(photo)):
                switch state.scene {
                case var .welcomeBack(chill):
                    chill.photo = photo

                    return .run { [chill] send in
                        await send(
                            .stopChillResult(Result {
                                try await self.gatewayClient.endChill(
                                    chill.id.uuidString,
                                    chill.traces,
                                    chill.photo,
                                    chill.distanceMeters,
                                    .now
                                )
                            })
                        )
                    }

                default:
                    break
                }
                return .none

            case let .savePhotoResult(.failure(error)):
                state.alert = .init(title: {
                    .init(error.localizedDescription)
                })
                return .none

            case .stopChillResult(.success(_)):
                switch state.scene {
                case .welcomeBack(_):
                    state.scene = .ready

                default:
                    break
                }
                return .none

            case let .stopChillResult(.failure(error)):
                state.alert = .init(title: {
                    .init(error.localizedDescription)
                })
                return .none
            }
        }
    }
}
