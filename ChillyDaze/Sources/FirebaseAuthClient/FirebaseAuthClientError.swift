import Foundation

extension FirebaseAuthClient {
    public enum FirebaseAuthClientError: LocalizedError {
        case failedToAuthenticate
        case currentUserNotFound

        public var errorDescription: String? {
            switch self {
            case .failedToAuthenticate:
                return "Failed to authenticate."

            case .currentUserNotFound:
                return "Current user was not found."
            }
        }
    }
}
