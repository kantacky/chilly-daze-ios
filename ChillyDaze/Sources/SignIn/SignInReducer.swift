import AuthClient
import AuthenticationServices
import ComposableArchitecture
import FirebaseAuth
import GatewayClient
import Models

@Reducer
public struct SignInReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case firebaseAuthResult(Result<FirebaseAuth.User, Error>)
        case registerUserResult(Result<Models.User, Error>)
        case signInWithAppleResult(Result<ASAuthorization, Error>)
    }

    // MARK: - Dependencies
    @Dependency(\.authClient)
    private var authClient
    @Dependency(\.gatewayClient)
    private var gatewayClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case let .firebaseAuthResult(.success(user)):
                return .run { send in
                    await send(
                        .registerUserResult(Result {
                            try await self.gatewayClient.registerUser(user.displayName ?? "")
                        })
                    )
                }

            case .firebaseAuthResult(.failure(_)):
                return .none

            case .registerUserResult(.success(_)):
                return .none

            case .registerUserResult(.failure(_)):
                return .none

            case let .signInWithAppleResult(.success(authResults)):
                return .run { send in
                    await send(
                        .firebaseAuthResult(Result {
                            try await self.authClient.signInWithApple(authResults)
                        })
                    )
                }

            case let .signInWithAppleResult(.failure(error)):
                print(error.localizedDescription)
                return .none
            }
        }
    }
}
