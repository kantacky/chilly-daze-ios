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

public extension Achievement {
    static func fromGateway(achievement: Gateway.AchievementsQuery.Data.Achievement) -> Self {
        let category: AchievementCategory = .fromGateway(category: achievement.category)

        return .init(
            id: achievement.id,
            name: achievement.name,
            displayName: achievement.displayName,
            description: achievement.description,
            category: category
        )
    }

    static func fromGateway(achievement: Gateway.UserAchievementsQuery.Data.User.Achievement) -> Self {
        let category: AchievementCategory = .fromGateway(category: achievement.category)

        return .init(
            id: achievement.id,
            name: achievement.name,
            displayName: achievement.displayName,
            description: achievement.description,
            category: category
        )
    }

    static func fromGateway(achievement: Gateway.EndChillMutation.Data.EndChill.NewAchievement) -> Self {
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

public extension Achievement {
    static let sample0: Self = .init(
        id: UUID().uuidString,
        name: "area1",
        displayName: "色水",
        description: "1日で近所の新しい景色を見た",
        category: .sample0
    )
    static let sample1: Self = .init(
        id: UUID().uuidString,
        name: "area2",
        displayName: "ハケ",
        description: "1週間で町のまだ見ぬ景色をみた",
        category: .sample0
    )
    static let sample2: Self = .init(
        id: UUID().uuidString,
        name: "area3",
        displayName: "世界",
        description: "1週間で少し遠くの新しい景色をみた",
        category: .sample0
    )
    static let sample3: Self = .init(
        id: UUID().uuidString,
        name: "frequency1",
        displayName: "ケーキ",
        description: "はじめての記録",
        category: .sample1
    )
    static let sample4: Self = .init(
        id: UUID().uuidString,
        name: "frequency2",
        displayName: "リュック",
        description: "3回記録した",
        category: .sample1
    )
    static let sample5: Self = .init(
        id: UUID().uuidString,
        name: "frequency3",
        displayName: "写真",
        description: "7回記録した",
        category: .sample1
    )
    static let sample6: Self = .init(
        id: UUID().uuidString,
        name: "continuous1",
        displayName: "星1つ",
        description: "連続3日記録した",
        category: .sample2
    )
    static let sample7: Self = .init(
        id: UUID().uuidString,
        name: "continuous2",
        displayName: "星2つ",
        description: "連続7日記録した",
        category: .sample2
    )
    static let sample8: Self = .init(
        id: UUID().uuidString,
        name: "continuous3",
        displayName: "星3つ",
        description: "連続20日記録した",
        category: .sample2
    )

    static let samples0: [Self] = [
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

    static let samples1: [Self] = [
        .sample0,
        .sample1,
        .sample3
    ]
}
