import Foundation
import Gateway

public struct AchievementCategory: Identifiable, Equatable {
    public let id: String
    public let name: String
    public let displayName: String

    init(
        id: String,
        name: String,
        displayName: String
    ) {
        self.id = id
        self.name = name
        self.displayName = displayName
    }
}

extension AchievementCategory {
    public static func fromGateway(category: Gateway.AchievementsQuery.Data.Achievement.Category) -> Self {
        .init(
            id: category.id,
            name: category.name,
            displayName: category.displayName
        )
    }

    public static func fromGateway(category: UserAchievementsQuery.Data.User.Achievement.Category) -> Self {
        .init(
            id: category.id,
            name: category.name,
            displayName: category.displayName
        )
    }

    public static func fromGateway(category: Gateway.EndChillMutation.Data.EndChill.NewAchievement.Category) -> Self {
        .init(
            id: category.id,
            name: category.name,
            displayName: category.displayName
        )
    }
}

public extension AchievementCategory {
    static let sample0: Self = .init(id: UUID().uuidString, name: "area", displayName: "面積")
    static let sample1: Self = .init(id: UUID().uuidString, name: "frequency", displayName: "回数")
    static let sample2: Self = .init(id: UUID().uuidString, name: "continuous", displayName: "連続")
}
