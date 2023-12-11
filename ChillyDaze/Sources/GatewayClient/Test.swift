import Dependencies
import Foundation

extension GatewayClient: TestDependencyKey {
    public static let testValue: Self = .init(
        registerUser: unimplemented("\(Self.self)"),
        getUser: unimplemented("\(Self.self)"),
        getChills: unimplemented("\(Self.self)"),
        getAchievements: unimplemented("\(Self.self)"),
        getUserAchievements: unimplemented("\(Self.self)"),
        startChill: unimplemented("\(Self.self)"),
        addTracePoint: unimplemented("\(Self.self)"),
        addPhoto: unimplemented("\(Self.self)"),
        endChill: unimplemented("\(Self.self)")
    )

    public static let previewValue = Self.testValue
}
