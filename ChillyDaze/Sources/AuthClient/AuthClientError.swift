import Foundation

extension AuthClient {
    public enum AuthClientError: LocalizedError {
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