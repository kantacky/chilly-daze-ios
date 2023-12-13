import ComposableArchitecture
import GatewayClient
import LocationManager
import _MapKit_SwiftUI
import Models

public struct ChillMapReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        @BindingState var mapCameraPosition: MapCameraPosition
        var chill: Chill?
        var chills: DataStatus<[Chill]>

        public init() {
            self.mapCameraPosition = .camera(
                .init(
                    centerCoordinate: .init(latitude: 0, longitude: 0),
                    distance: 3000
                )
            )

            self.chills = .initialized
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case alert(PresentationAction<Alert>)
        case binding(BindingAction<State>)
        case onAppear
        case onChangeCoordinate(CLLocationCoordinate2D)
        case onStartButtonTapped
        case startChillResult(Result<Chill, Error>)
        case onStopButtonTapped
        case stopChillResult(Result<Chill, Error>)
        case onCameraButtonTapped

        public enum Alert: Equatable {}
    }

    // MARK: - Dependencies
    @Dependency(\.locationManager)
    private var locationManager
    @Dependency(\.gatewayClient)
    private var gatewayClient

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

                return .run { send in
                    for await value in self.locationManager.getLocationStream() {
                        Task.detached { @MainActor in
                            send(.onChangeCoordinate(value))
                        }
                    }
                }
                .cancellable(id: CancelID.coordinateSubscription)

            case let .onChangeCoordinate(coordinate):
                if state.chill != nil {
                    let tracePoint: TracePoint = .init(id: UUID().uuidString, timestamp: .now, coordinate: coordinate)
                    state.chill?.traces.append(tracePoint)
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
                state.chill = chill
                return .none

            case let .startChillResult(.failure(error)):
                state.alert = .init(title: { .init(error.localizedDescription) })
                return .none

            case .onStopButtonTapped:
                guard let chillId = state.chill?.id else { return .none }

                return .run { send in
                    await send(
                        .stopChillResult(Result {
                            let coordinate: CLLocationCoordinate2D = try self.locationManager.getCurrentLocation()

                            return try await self.gatewayClient.endChill(
                                chillId,
                                .now,
                                coordinate.latitude,
                                coordinate.longitude
                            )
                        })
                    )
                }

            case let .stopChillResult(.success(chill)):
                state.chill = chill
                return .none

            case let .stopChillResult(.failure(error)):
                state.alert = .init(title: { .init(error.localizedDescription) })
                return .none

            case .onCameraButtonTapped:
                return .none
            }
        }
    }
}
