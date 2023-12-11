import AuthenticationServices
import ComposableArchitecture
import FirebaseAuth
import FirebaseAuthClient

public struct SignInReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case firebaseAuthResult(Result<AuthDataResult, Error>)
        case signInWithAppleResult(Result<ASAuthorization, Error>)
    }

    // MARK: - Dependencies
    @Dependency(\.firebaseAuthClient)
    private var firebaseAuthClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .firebaseAuthResult(.success(_)):
                return .none

            case .firebaseAuthResult(.failure(_)):
                return .none

            case let .signInWithAppleResult(.success(authResults)):
                return .run { send in
                    await send(.firebaseAuthResult(Result {
                        try await self.firebaseAuthClient.signInWithApple(authResults)
                    }))
                }

            case let .signInWithAppleResult(.failure(error)):
                print(error.localizedDescription)
                return .none
            }
        }
    }
}
