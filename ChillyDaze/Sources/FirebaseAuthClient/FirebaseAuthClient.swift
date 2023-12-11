import FirebaseAuth
import AuthenticationServices
import Foundation

public struct FirebaseAuthClient {
    public private(set) var signInWithApple: @Sendable (ASAuthorization) async throws -> AuthDataResult
    public private(set) var getCredentialStateOfSignInWithApple: @Sendable () async throws -> ASAuthorizationAppleIDProvider.CredentialState
    public private(set) var getCurrentUser: @Sendable () throws -> User
    public private(set) var signOut: @Sendable() throws -> Void

    public init(
        signInWithApple: @escaping @Sendable (ASAuthorization) async throws -> AuthDataResult,
        getCredentialStateOfSignInWithApple: @escaping @Sendable () async throws -> ASAuthorizationAppleIDProvider.CredentialState,
        getCurrentUser: @escaping @Sendable () throws -> User,
        signOut: @escaping @Sendable() throws -> Void
    ) {
        self.signInWithApple = signInWithApple
        self.getCredentialStateOfSignInWithApple = getCredentialStateOfSignInWithApple
        self.getCurrentUser = getCurrentUser
        self.signOut = signOut
    }
}
