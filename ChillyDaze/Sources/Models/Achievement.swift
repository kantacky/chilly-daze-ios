import Foundation
import Gateway

public struct Achievement: Identifiable, Equatable {
    public let id: ID
    public let name: String
    public let displayName: String
    public let description: String
    public let category: AchievementCategory

    public init(
        id: ID,
        name: String,
        displayName: String,
        description: String,
        category: AchievementCategory
    ) {
        self.id = id
        self.name = name
        self.displayName = displayName
        self.description = description
        self.category = category
    }
}

extension Achievement {
    public static func fromGateway(achievement: Gateway.AchievementsQuery.Data.Achievement) -> Self {
        let category: AchievementCategory = .fromGateway(category: achievement.category)

        return .init(
            id: achievement.id,
            name: achievement.name,
            displayName: achievement.displayName,
            description: achievement.description,
            category: category
        )
    }

    public static func fromGateway(achievement: Gateway.UserAchievementsQuery.Data.User.Achievement) -> Self {
        let category: AchievementCategory = .fromGateway(category: achievement.category)

        return .init(
            id: achievement.id,
            name: achievement.name,
            displayName: achievement.displayName,
            description: achievement.description,
            category: category
        )
    }

    public static func fromGateway(achievement: Gateway.EndChillMutation.Data.EndChill.NewAchievement) -> Self {
        let category: AchievementCategory = .fromGateway(category: achievement.category)

        return .init(
            id: achievement.id,
            name: achievement.name,
            displayName: achievement.displayName,
            description: achievement.description,
            category: category
        )
    }
}

extension Achievement {
    public static let sample0: Self = .init(
        id: UUID().uuidString,
        name: "area1",
        displayName: "面積1",
        description: "これは、面積アチーブメント1です。",
        category: .sample0
    )
    public static let sample1: Self = .init(
        id: UUID().uuidString,
        name: "area2",
        displayName: "面積2",
        description: "これは、面積アチーブメント2です。",
        category: .sample0
    )
    public static let sample2: Self = .init(
        id: UUID().uuidString,
        name: "area3",
        displayName: "面積3",
        description: "これは、面積アチーブメント3です。",
        category: .sample0
    )
    public static let sample3: Self = .init(
        id: UUID().uuidString,
        name: "frequency1",
        displayName: "回数1",
        description: "これは、回数アチーブメント1です。",
        category: .sample1
    )
    public static let sample4: Self = .init(
        id: UUID().uuidString,
        name: "frequency2",
        displayName: "回数2",
        description: "これは、回数アチーブメント2です。",
        category: .sample1
    )
    public static let sample5: Self = .init(
        id: UUID().uuidString,
        name: "frequency3",
        displayName: "回数3",
        description: "これは、回数アチーブメント3です。",
        category: .sample1
    )
    public static let sample6: Self = .init(
        id: UUID().uuidString,
        name: "continuous1",
        displayName: "連続1",
        description: "これは、連続アチーブメント1です。",
        category: .sample2
    )
    public static let sample7: Self = .init(
        id: UUID().uuidString,
        name: "continuous2",
        displayName: "連続2",
        description: "これは、連続アチーブメント2です。",
        category: .sample2
    )
    public static let sample8: Self = .init(
        id: UUID().uuidString,
        name: "continuous3",
        displayName: "連続3",
        description: "これは、連続アチーブメント3です。",
        category: .sample2
    )

    public static let samples0: [Self] = [
        .sample0,
        .sample1,
        .sample2,
        .sample3,
        .sample4,
        .sample5,
        .sample6,
        .sample7,
        .sample8,
    ]

    public static let samples1: [Self] = [
        .sample0,
        .sample1,
        .sample3
    ]
}
