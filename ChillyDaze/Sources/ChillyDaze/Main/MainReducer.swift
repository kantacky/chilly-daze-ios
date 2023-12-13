import Achievement
import AuthClient
import ChillMap
import ComposableArchitecture
import Record

@Reducer
public struct MainReducer {
    // MARK: - State
    public enum State: Equatable {
        case chillMap(ChillMapReducer.State)
        case record(RecordReducer.State)
        case achievement(AchievementReducer.State)

        public init() {
            self = .chillMap(.init())
        }
    }

    // MARK: - Action
    public enum Action {
        case onTabButtonTapped(State)
        case achievement(AchievementReducer.Action)
        case chillMap(ChillMapReducer.Action)
        case record(RecordReducer.Action)
    }

    // MARK: - Dependencies
    @Dependency(\.authClient)
    private var authClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .onTabButtonTapped(newState):
                state = newState

                return .none

            case .achievement:
                return .none

            case .chillMap:
                return .none

            case .record:
                return .none
            }
        }
        .ifCaseLet(/State.achievement, action: /Action.achievement) {
            AchievementReducer()
        }
        .ifCaseLet(/State.chillMap, action: /Action.chillMap) {
            ChillMapReducer()
        }
        .ifCaseLet(/State.record, action: /Action.record) {
            RecordReducer()
        }
    }
}
