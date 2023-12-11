import AuthenticationServices
import Dependencies
import FirebaseAuth
import Foundation
import KeychainSwift

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

            let user = firebaseAuthDataResult.user

            let firebaseIdToken = try await user.getIDToken()

            let keychain = KeychainSwift()
            keychain.set(firebaseIdToken, forKey: "idToken")

            return user
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

            let idToken = try await user.getIDToken()

            let keychain = KeychainSwift()
            keychain.set(idToken, forKey: "idToken")

            return user
        },
        signOut: {
            let keychain = KeychainSwift()
            keychain.clear()

            try Auth.auth().signOut()
        }
    )
}
