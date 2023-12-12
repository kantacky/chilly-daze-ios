import AuthClient
import ComposableArchitecture

@Reducer
public struct MainReducer {
    // MARK: - State
    public struct State: Equatable {
        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case onSignOutButtonTapped
    }

    // MARK: - Dependencies
    @Dependency(\.authClient)
    private var authClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onSignOutButtonTapped:
                do {
                    try self.authClient.signOut()
                } catch {
                    print(error.localizedDescription)
                }
                return .none
            }
        }
    }
}
