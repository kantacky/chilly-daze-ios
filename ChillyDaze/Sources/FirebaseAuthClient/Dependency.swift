import Dependencies

public extension DependencyValues {
    var firebaseAuthClient: FirebaseAuthClient {
        get { self[FirebaseAuthClient.self] }
        set { self[FirebaseAuthClient.self] = newValue }
    }
}
