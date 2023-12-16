import ComposableArchitecture
import GatewayClient
import Models

@Reducer
public struct RecordReducer {
    // MARK: - State
    public struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        var chills: DataStatus<[Chill]>
        var areaWeekPercent: Int {
            switch self.chills {
            case let .loaded(chills):
                let totalDistance = chills.map{ $0.distanceMeters }.reduce(0, +)
                return Int(totalDistance / (4000 * 7) * 100)

            default:
                return 0
            }
        }

        public init() {
            self.chills = .initialized
        }
    }

    // MARK: - Action
    public enum Action {
        case alert(PresentationAction<Alert>)
        case onAppear
        case onRefresh
        case getChillsResult(Result<[Chill], Error>)

        public enum Alert: Equatable {}
    }

    // MARK: - Dependencies
    @Dependency(\.gatewayClient)
    private var gatewayClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert:
                return .none

            case .onAppear:
                return .send(.onRefresh)

            case .onRefresh:
                state.chills = .loading
                return .run { send in
                    await send(.getChillsResult(Result {
                        try await self.gatewayClient.getChills()
                    }))
                }

            case let .getChillsResult(.success(chills)):
                state.chills = .loaded(chills)
                return .none

            case let .getChillsResult(.failure(error)):
                state.alert = .init(title: .init(error.localizedDescription))
                state.chills = .initialized
                return .none
            }
        }
    }
}
