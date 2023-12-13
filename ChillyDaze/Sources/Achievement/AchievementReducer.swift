import ComposableArchitecture

public struct AchievementReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        @PresentationState var settings: SettingsReducer.State?

        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case onSettingsButtonTapped
        case settings(PresentationAction<SettingsReducer.Action>)
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onSettingsButtonTapped:
                state.settings = .init()
                return .none

            case .settings(.presented(.onXButtonTapped)):
                state.settings = nil
                return .none

            case .settings:
                return .none
            }
        }
        .ifLet(\.$settings, action: /Action.settings) {
            SettingsReducer()
        }
    }
}
