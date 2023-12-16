import Models
import SwiftUI

struct WelcomeBackImageView: View {
    private let chill: Chill
    private let index: Int

    init(chill: Chill, index: Int) {
        self.chill = chill
        self.index = index
    }

    var body: some View {
        Group {
            if let shots = self.chill.shots, !shots.isEmpty {
                ZStack {
                    Image(uiImage: shots[self.index].image).resizable()
                        .aspectRatio(contentMode: .fill)

                    VStack(spacing: 0) {
                        Spacer()

                        ChillyIndicator(chillRate: self.chill.distanceMeters / 4000)
                            .frame(width: 252)

                        Spacer().frame(height: 22)
                    }
                }
            }
            else {
                VStack(alignment: .leading, spacing: 28) {
                    Image.iChilled.resizable().scaledToFit().frame(width: 140)

                    ChillyIndicator(chillRate: self.chill.distanceMeters / 4000)
                }
                .frame(width: 252)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        .background(Color.chillyWhite)
    }
}

#Preview { WelcomeBackImageView(chill: Chill.samples[0], index: 0) }
