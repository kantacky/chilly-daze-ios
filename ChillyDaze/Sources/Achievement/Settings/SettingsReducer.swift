import AuthClient
import ComposableArchitecture

public struct SettingsReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case onXButtonTapped
        case onAvatarTapped
        case onEditUsernameButtonTapped
        case onSignOutButtonTapped
        case onDeleteAccountButtonTapped
    }

    // MARK: - Dependencies
    @Dependency(\.authClient)
    private var authClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onXButtonTapped:
                return .none

            case .onAvatarTapped:
                return .none

            case .onEditUsernameButtonTapped:
                return .none

            case .onSignOutButtonTapped:
                do {
                    try self.authClient.signOut()
                } catch {
                    print(error.localizedDescription)
                }
                return .none

            case .onDeleteAccountButtonTapped:
                return .none
            }
        }
    }
}
