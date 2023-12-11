import AuthenticationServices
import ComposableArchitecture
import FirebaseAuth
import FirebaseAuthClient
import SignIn

public struct AppReducer: Reducer {
    // MARK: - State
    public enum State: Equatable {
        case launch
        case signIn(SignInReducer.State)
        case main(MainReducer.State)

        public init() {
            self = .launch
        }
    }

    // MARK: - Action
    public enum Action {
        case onAppear
        case getCurrentUserResult(Result<User, Error>)
        case signIn(SignInReducer.Action)
        case main(MainReducer.Action)
    }

    // MARK: - Dependencies
    @Dependency(\.firebaseAuthClient)
    private var firebaseAuthClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.getCurrentUserResult(Result {
                        try await self.firebaseAuthClient.getCurrentUser()
                    }))
                }

            case .getCurrentUserResult(.success(_)):
                state = .main(.init())
                return .none

            case .getCurrentUserResult(.failure(_)):
                state = .signIn(.init())
                return .none

            case .signIn(.firebaseAuthResult(_)):
                state = .main(.init())
                return .none

            case .main(.onSignOutButtonTapped):
                state = .signIn(.init())
                return .none

            case .signIn:
                return .none

            case .main:
                return .none
            }
        }
        .ifCaseLet(/State.signIn, action: /Action.signIn) {
            SignInReducer()
        }
        .ifCaseLet(/State.main, action: /Action.main) {
            MainReducer()
        }
    }
}
