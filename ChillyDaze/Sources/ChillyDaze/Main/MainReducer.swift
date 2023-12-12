import Achievement
import AuthClient
import ChillMap
import ComposableArchitecture
import Record

@Reducer
public struct MainReducer {
    // MARK: - State
    public struct State: Equatable {
        var achievement: AchievementReducer.State
        var chillMap: ChillMapReducer.State
        var record: RecordReducer.State

        public init() {
            self.achievement = .init()
            self.chillMap = .init()
            self.record = .init()
        }
    }

    // MARK: - Action
    public enum Action {
        case onSignOutButtonTapped
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
        Scope(state: \.achievement, action: /Action.achievement) {
            AchievementReducer()
        }

        Scope(state: \.chillMap, action: /Action.chillMap) {
            ChillMapReducer()
        }

        Scope(state: \.record, action: /Action.record) {
            RecordReducer()
        }

        Reduce { state, action in
            switch action {
            case .onSignOutButtonTapped:
                do {
                    try self.authClient.signOut()
                } catch {
                    print(error.localizedDescription)
                }
                return .none

            case .achievement:
                return .none

            case .chillMap:
                return .none

            case .record:
                return .none
            }
        }
    }
}
