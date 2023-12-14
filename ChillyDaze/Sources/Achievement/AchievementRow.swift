import Models
import NukeUI
import SwiftUI

struct AchievementRow: View {
    private let categoryName: String
    private let achievements: DataStatus<[Achievement]>

    init(
        categoryName: String,
        achievements: DataStatus<[Achievement]>
    ) {
        self.categoryName = categoryName
        self.achievements = achievements
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(self.categoryName)
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
                        ForEach(userAchievements.filter { $0.category == self.categoryName } ) { achievement in
                            if let url = achievement.image {
                                LazyImage(url: url) { state in
                                    if let image = state.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 96, height: 96)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle()
                                                    .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                            }
                                    } else if state.error != nil {
                                        Circle()
                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                            .fill(Color.chillyWhite)
                                            .frame(width: 96, height: 96)
                                    } else {
                                        Circle()
                                            .stroke(Color.chillyBlack, style: StrokeStyle(lineWidth: 2))
                                            .fill(Color.chillyWhite)
                                            .frame(width: 96, height: 96)
                                    }
                                }
                            } else {
                                Image.Achievement.achievementDefault
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
        categoryName: "面積",
        achievements: .loaded(Achievement.samples1)
    )
}
