import Models
import NukeUI
import Resources
import SwiftUI

struct WelcomeBackView: View {
    private let chill: Chill
    private let action: (Shot) -> Void
    private let chillRatePercent: Int
    @State private var shareImage: UIImage?
    @State private var imageIndex: Int

    init(
        chill: Chill,
        action: @escaping (Shot) -> Void
    ) {
        Font.registerCustomFonts()
        self.chill = chill
        self.action = action
        self.chillRatePercent = Int(self.chill.distanceMeters / 4000 * 100)
        self._imageIndex = .init(initialValue: 0)
    }

    var body: some View {
        VStack(spacing: 62) {
            VStack(spacing: 32) {
                Image.welcomeBack
                    .resizable()
                    .scaledToFit()
                    .frame(width: 265)

                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 2)

                    WelcomeBackImageView(chill: self.chill, index: self.imageIndex)

                    Rectangle()
                        .frame(height: 2)
                }
            }

            HStack(spacing: 26) {
                if let image = self.shareImage {
                    ShareLink(
                        item: Image(uiImage: image),
                        subject: Text("Chill in Chilly Daze"),
                        message: Text("I chilled \(self.chillRatePercent)%"),
                        preview: .init(
                            "Chill in Chilly Daze\nI chilled \(self.chillRatePercent)%",
                            image: Image(uiImage: image)
                        )
                    ) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.customFont(.inikaBold, size: 20))
                            .padding(.horizontal, 16)
                            .frame(height: 54)
                            .foregroundStyle(Color.chillyBlack)
                            .background(Color.chillyYellow)
                            .border(Color.chillyBlack, width: 2)
                    }

                    ChillyButton(
                        labelText: "Ok",
                        foregroundColor: .chillyWhite,
                        backgroundColor: .chillyBlack
                    ) {
                        if let shots = self.chill.shots,
                           !shots.isEmpty {
                            let timestamp: Date =  shots[self.imageIndex].timestamp
                            let shot: Shot = .init(timestamp: timestamp, image: image)
                            self.action(shot)
                        } else {
                            let shot: Shot = .init(timestamp: .now, image: image)
                            self.action(shot)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chillyWhite)
        .task {
            let renderer = ImageRenderer(content: WelcomeBackImageView(chill: self.chill, index: self.imageIndex))

            if let uiImage = renderer.uiImage {
                self.shareImage = uiImage
            }
        }
    }
}

#Preview {
    WelcomeBackView(chill: .samples[0]) { _ in }
}
