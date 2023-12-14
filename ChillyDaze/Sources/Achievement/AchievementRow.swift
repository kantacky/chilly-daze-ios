import Models
import NukeUI
import SwiftUI

struct AchievementRow: View {
    private let category: AchievementCategory
    private let achievements: DataStatus<[Achievement]>

    init(
        category: AchievementCategory,
        achievements: DataStatus<[Achievement]>
    ) {
        self.category = category
        self.achievements = achievements
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(self.category.displayName)
                .font(Font.customFont(.zenKakuGothicAntiqueMedium, size: 20))
            ScrollView(.horizontal, showsIndicators: false) {
                switch self.achievements {
                case .initialized, .loading:
                    HStack {
                        Rectangle()
                            .fill(Color.chillyBlack)
                            .frame(width: 100, height: 100)
                        Rectangle()
                            .fill(Color.chillyBlack)
                            .frame(width: 100, height: 100)
                        Rectangle()
                            .fill(Color.chillyBlack)
                            .frame(width: 100, height: 100)
                        Rectangle()
                            .fill(Color.chillyBlack)
                            .frame(width: 100, height: 100)
                    }

                case let .loaded(userAchievements):
                    HStack {
                        ForEach(userAchievements.filter { $0.category.id == self.category.id }) { achievement in
                            Image.Achievement.image(achievement.name, isActive: true)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 96, height: 96)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                }
                        }
                    }
                    .padding(4)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    AchievementRow(
        category: .sample0,
        achievements: .loaded(Achievement.samples1)
    )
}
