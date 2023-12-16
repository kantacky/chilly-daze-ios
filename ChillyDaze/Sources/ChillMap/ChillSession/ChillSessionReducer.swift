import ComposableArchitecture
import _MapKit_SwiftUI
import CoreLocation
import LocationManager
import Models

@Reducer
public struct ChillSessionReducer {
    // MARK: - State
    public struct State: Equatable {
        var chills: [Chill]
        var chill: Chill
        @PresentationState var chillyAlert: ChillyAlertReducer.State?
        @BindingState var mapCameraPosition: MapCameraPosition

        public init(
            chills: [Chill],
            chill: Chill
        ) {
            self.chills = chills
            self.chill = chill

            self.mapCameraPosition = .camera(
                .init(
                    centerCoordinate: .init(latitude: 0, longitude: 0),
                    distance: 3000
                )
            )
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case onChangeCoordinate(CLLocationCoordinate2D)
        case onStopButtonTapped
        case onCameraButtonTapped
        case onEndChill(Chill)
        case chillyAlert(PresentationAction<ChillyAlertReducer.Action>)
    }

    // MARK: - Dependencies
    @Dependency(\.locationManager)
    private var locationManager

    public enum CancelID {
        case coordinateSubscription
    }

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onAppear:
                do {
                    let coordinate = try self.locationManager.getCurrentLocation()

                    state.mapCameraPosition = .camera(
                        .init(
                            centerCoordinate: coordinate,
                            distance: state.mapCameraPosition.camera?.distance ?? 3000
                        )
                    )
                } catch {
                    print(error.localizedDescription)
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
                if !state.chill.traces.isEmpty {
                    state.chill.distanceMeters += state.chill.traces.sorted(by: { $0.timestamp > $1.timestamp })[0].coordinate.location.distance(from: coordinate.location)
                }

                let tracePoint: TracePoint = .init(timestamp: .now, coordinate: coordinate)
                state.chill.traces.append(tracePoint)

                return .none

            case .onStopButtonTapped:
                state.chillyAlert = .init(message: "アクティビティを終了しますか？", primaryButtonLabelText: "終了")
                return .none

            case .chillyAlert(.presented(.onPrimaryButtonTapped)):
                return .send(.onEndChill(state.chill))

            case .chillyAlert(.presented(.onSecondaryButtonTapped)):
                state.chillyAlert = nil
                return .none

            case .onCameraButtonTapped:
                return .none

            case .onEndChill(_):
                return .none

            case .chillyAlert:
                return .none
            }
        }
        .ifLet(\.$chillyAlert, action: \.chillyAlert) {
            ChillyAlertReducer()
        }
    }
}
