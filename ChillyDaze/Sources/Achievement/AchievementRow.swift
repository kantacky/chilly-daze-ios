import Models
import NukeUI
import SwiftUI

struct AchievementRow: View {
    private let category: AchievementCategory
    private let achievements: [Achievement]
    private let userAchievements: [Achievement]

    init(
        category: AchievementCategory,
        achievements: [Achievement],
        userAchievements: [Achievement]
    ) {
        self.category = category
        self.achievements = achievements
        self.userAchievements = userAchievements
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(self.category.displayName)
                .font(Font.customFont(.zenKakuGothicAntiqueMedium, size: 20))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(achievements.filter { $0.category.id == self.category.id }) { achievement in
                        Image.Achievement.image(
                            achievement.name,
                            isActive: self.userAchievements.map {
                                $0.name == achievement.name
                            }.contains(true)
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .strokeBorder(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                        }
                    }
                }
                .padding(4)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    AchievementRow(
        category: .sample0,
        achievements: Achievement.samples0,
        userAchievements: Achievement.samples1
    )
}