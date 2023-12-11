import ComposableArchitecture
import FirebaseAuthClient

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
    @Dependency(\.firebaseAuthClient)
    private var firebaseAuthClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onSignOutButtonTapped:
                do {
                    try self.firebaseAuthClient.signOut()
                } catch {
                    print(error.localizedDescription)
                }
                return .none
            }
        }
    }
}
