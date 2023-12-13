import ComposableArchitecture
import LocationManager
import _MapKit_SwiftUI

public struct ChillMapReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        @BindingState var mapCameraPosition: MapCameraPosition

        public init() {
            self.mapCameraPosition = .camera(
                .init(
                    centerCoordinate: .init(latitude: 0, longitude: 0),
                    distance: 1000
                )
            )
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
    }

    // MARK: - Dependencies
    @Dependency(\.locationManager)
    private var locationManager

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        BindingReducer()

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
                            distance: state.mapCameraPosition.camera?.distance ?? 1000
                        )
                    )
                } catch {
                    return .none
                }

                return .none
            }
        }
    }
}
