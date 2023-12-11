import Foundation
import Models

public struct GatewayClient {
    public var registerUser: @Sendable (String) async throws -> User

    public var getUser: @Sendable () async throws -> User
    public var getChills: @Sendable () async throws -> [Chill]
    public var getAchievements: @Sendable () async throws -> [Achievement]
    public var getUserAchievements: @Sendable () async throws -> [Achievement]

    public var startChill: @Sendable (Date, Double, Double) async throws -> Chill
    public var addTracePoint: @Sendable (String, Date, Double, Double) async throws -> TracePoint
    public var addPhoto: @Sendable (String, Date, String) async throws -> Photo
    public var endChill: @Sendable (String, Date, Double, Double) async throws -> Chill

    public init(
        registerUser: @escaping @Sendable (String) async throws -> User,
        getUser: @escaping @Sendable () async throws -> User,
        getChills: @escaping @Sendable () async throws -> [Chill],
        getAchievements: @escaping @Sendable () async throws -> [Achievement],
        getUserAchievements: @escaping @Sendable () async throws -> [Achievement],
        startChill: @escaping @Sendable (Date, Double, Double) async throws -> Chill,
        addTracePoint: @escaping @Sendable (String, Date, Double, Double) async throws -> TracePoint,
        addPhoto: @escaping @Sendable (String, Date, String) async throws -> Photo,
        endChill: @escaping @Sendable (String, Date, Double, Double) async throws -> Chill
    ) {
        self.registerUser = registerUser
        self.getUser = getUser
        self.getChills = getChills
        self.getAchievements = getAchievements
        self.getUserAchievements = getUserAchievements
        self.startChill = startChill
        self.addTracePoint = addTracePoint
        self.addPhoto = addPhoto
        self.endChill = endChill
    }
}
