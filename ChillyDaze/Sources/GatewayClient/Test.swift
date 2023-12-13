import Dependencies
import Foundation
import Models

extension GatewayClient: TestDependencyKey {
    public static let testValue: Self = .init(
        registerUser: unimplemented("\(Self.self)"),
        getUser: {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return User.sample0
        },
        getChills: {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return []
        },
        getAchievements: {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return Achievement.samples0
        },
        getUserAchievements: {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return Achievement.samples1
        },
        startChill: unimplemented("\(Self.self)"),
        endChill: unimplemented("\(Self.self)")
    )

    public static let previewValue = Self.testValue
}
