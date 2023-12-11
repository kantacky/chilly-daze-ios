import Foundation
import Gateway

public struct Achievement: Identifiable, Equatable {
    public let id: ID
    public let name: String
    public let description: String

    public init(
        id: ID,
        name: String,
        description: String
    ) {
        self.id = id
        self.name = name
        self.description = description
    }
}

extension Achievement {
    public static func fromGateway(achievement: Gateway.AchievementsQuery.Data.Achievement) -> Self {
        .init(
            id: achievement.id,
            name: achievement.name,
            description: achievement.description
        )
    }

    public static func fromGateway(achievement: Gateway.UserAchievementsQuery.Data.User.Achievement) -> Self {
        .init(
            id: achievement.id,
            name: achievement.name,
            description: achievement.description
        )
    }
}
