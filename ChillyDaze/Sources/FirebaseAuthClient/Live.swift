import AuthenticationServices
import Dependencies
import FirebaseAuth
import Foundation

extension FirebaseAuthClient: DependencyKey {
    public static let liveValue: Self = .init(
        signInWithApple: { authResults in
            guard let appleIdCredential = authResults.credential as? ASAuthorizationAppleIDCredential,
                  let idToken = appleIdCredential.identityToken,
                  let idTokenString = String(data: idToken, encoding: .utf8),
                  let fullName = appleIdCredential.fullName,
                  let email = appleIdCredential.email
            else { throw FirebaseAuthClientError.failedToAuthenticate }

            let userId = appleIdCredential.user

            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString, rawNonce: nil, fullName: fullName)

            let firebaseAuthDataResult = try await Auth.auth().signIn(with: credential)

            return firebaseAuthDataResult
        },
        getCredentialStateOfSignInWithApple: {
            guard let userID = Auth.auth().currentUser?.uid else { throw FirebaseAuthClientError.currentUserNotFound }

            return try await withCheckedThrowingContinuation { continuation in
                let provider: ASAuthorizationAppleIDProvider = .init()
                provider.getCredentialState(forUserID: userID) { credentialState, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }

                    continuation.resume(returning: credentialState)
                }
            }
        },
        getCurrentUser: {
            guard let user = Auth.auth().currentUser else { throw FirebaseAuthClientError.currentUserNotFound }
            return user
        },
        signOut: {
            try Auth.auth().signOut()
        }
    )
}
