import AuthClient
import AuthenticationServices
import ComposableArchitecture
import FirebaseAuth
import GatewayClient
import LocationManager
import Models
import SignIn

@Reducer
public struct AppReducer {
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
        case getCurrentUserResult(Result<FirebaseAuth.User, Error>)
        case registerUserResult(Result<Models.User, Error>)
        case signIn(SignInReducer.Action)
        case main(MainReducer.Action)
    }

    // MARK: - Dependencies
    @Dependency(\.authClient)
    private var authClient
    @Dependency(\.gatewayClient)
    private var gatewayClient
    @Dependency(\.locationManager)
    private var locationManager

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.getCurrentUserResult(Result {
                        try await self.authClient.getCurrentUser()
                    }))
                }

            case let .getCurrentUserResult(.success(user)):
                return .run { send in
                    await send(.registerUserResult(Result {
                        try await self.gatewayClient.registerUser(user.displayName ?? "", "")
                    }))
                }

            case .getCurrentUserResult(.failure(_)):
                state = .signIn(.init())
                return .none

            case .registerUserResult(.success(_)):
                state = .main(.init())
                return .none

            case .registerUserResult(.failure(_)):
                return .none

            case .signIn(.registerUserResult(.success(_))):
                state = .main(.init())
                return .none

            case .main(.achievement(.settings(.presented(.signOutResult(.success(_)))))):
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
