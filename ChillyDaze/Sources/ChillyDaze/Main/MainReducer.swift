import Achievement
import ChillMap
import ComposableArchitecture
import Record

@Reducer
struct MainReducer {
    // MARK: - State
    struct State: Equatable {
        var chillMap: ChillMapReducer.State
        var record: RecordReducer.State
        var achievement: AchievementReducer.State

        var tab: Tab

        init() {
            self.chillMap = .init()
            self.record = .init()
            self.achievement = .init()

            self.tab = .chillMap(self.chillMap)
        }

        @CasePathable
        enum Tab: Equatable {
            case chillMap(ChillMapReducer.State)
            case record(RecordReducer.State)
            case achievement(AchievementReducer.State)
        }
    }

    // MARK: - Action
    enum Action {
        case onTabButtonTapped(Tab)

        case chillMap(ChillMapReducer.Action)
        case record(RecordReducer.Action)
        case achievement(AchievementReducer.Action)
    }

    // MARK: - Dependencies

    init() {}

    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Scope(state: \.tab, action: \.self) {
            Scope(state: \.chillMap, action: \.chillMap) {
                ChillMapReducer()
            }
            Scope(state: \.record, action: \.record) {
                RecordReducer()
            }
            Scope(state: \.achievement, action: \.achievement) {
                AchievementReducer()
            }
        }

        Reduce { state, action in
            switch action {
            case let .onTabButtonTapped(newTab):
                switch newTab {
                case .chillMap:
                    state.tab = .chillMap(state.chillMap)

                case .record:
                    state.tab = .record(state.record)

                case .achievement:
                    state.tab = .achievement(state.achievement)
                }
                return .none

            case .record:
                return .none

            case .chillMap:
                return .none

            case .achievement:
                return .none
            }
        }
    }
}
