import Models
import Resources
import SwiftUI

struct NewAchievementDialog: View {
    private let achievement: Achievement
    private let action: () -> Void

    init(achievement: Achievement, action: @escaping () -> Void) {
        Font.registerCustomFonts()
        self.achievement = achievement
        self.action = action
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(self.achievement.description)
                .font(.customFont(.zenKakuGothicAntiqueMedium, size: 20))

            VStack(spacing: 32) {
                Image.Achievement.image(self.achievement.name, isActive: true).resizable()
                    .scaledToFit().frame(width: 208)

                ChillyButton(labelText: "Ok") { self.action() }
            }
        }
        .padding(32).frame(width: 318).background(Color.chillyWhite)
        .border(Color.chillyBlack, width: 2)
    }
}

#Preview { NewAchievementDialog(achievement: .samples[4]) {} }
