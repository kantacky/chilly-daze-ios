import Foundation
import Gateway

public struct Achievement: Identifiable, Equatable {
    public let id: ID
    public let name: String
    public let description: String
    public let category: String
    public let image: URL?

    public init(
        id: ID,
        name: String,
        description: String,
        category: String,
        image: URL?
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.image = image
    }
}

extension Achievement {
    public static func fromGateway(achievement: Gateway.AchievementsQuery.Data.Achievement) -> Self {
        .init(
            id: achievement.id,
            name: achievement.name,
            description: achievement.description,
            category: achievement.category,
            image: .init(string: achievement.image)
        )
    }

    public static func fromGateway(achievement: Gateway.UserAchievementsQuery.Data.User.Achievement) -> Self {
        .init(
            id: achievement.id,
            name: achievement.name,
            description: achievement.description,
            category: achievement.category,
            image: .init(string: achievement.image)
        )
    }

    public static func fromGateway(achievement: Gateway.EndChillMutation.Data.EndChill.NewAchievement) -> Self {
        .init(
            id: achievement.id,
            name: achievement.name,
            description: achievement.description,
            category: achievement.category,
            image: .init(string: achievement.image)
        )
    }
}

extension Achievement {
    public static let sample0: Self = .init(
        id: UUID().uuidString,
        name: "アチーブメント1",
        description: "これは、アチーブメント1です。",
        category: "面積",
        image: nil
    )
    public static let sample1: Self = .init(
        id: UUID().uuidString,
        name: "アチーブメント2",
        description: "これは、アチーブメント2です。",
        category: "面積",
        image: nil
    )
    public static let sample2: Self = .init(
        id: UUID().uuidString,
        name: "アチーブメント3",
        description: "これは、アチーブメント2です。",
        category: "面積",
        image: nil
    )

    public static let sample3: Self = .init(
        id: UUID().uuidString,
        name: "アチーブメント4",
        description: "これは、アチーブメント4です。",
        category: "回数",
        image: nil
    )

    public static let samples0: [Self] = [
        .sample0,
        .sample1,
        .sample2,
        .sample3
    ]

    public static let samples1: [Self] = [
        .sample0,
        .sample1,
        .sample2,
        .sample3
    ]
}
