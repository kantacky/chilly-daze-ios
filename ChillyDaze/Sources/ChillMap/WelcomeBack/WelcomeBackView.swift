import Models
import NukeUI
import Resources
import SwiftUI

struct WelcomeBackView: View {
    private let chill: Chill
    private let action: (Shot) -> Void
    @State private var shareImage: Image?
    @State private var imageIndex: Int

    init(
        chill: Chill,
        action: @escaping (Shot) -> Void
    ) {
        self.chill = chill
        self.action = action
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
                    ChillyButton(labelImage: "square.and.arrow.up") {
                        _ = ShareLink(
                            item: image,
                            subject: Text("Chill in Chilly Daze"),
                            message: Text("I chilled \(self.chill.distanceMeters / 4000)%"),
                            preview: SharePreview("Chill", image: image)
                        )
                    }

                    ChillyButton(
                        labelText: "Ok",
                        foregroundColor: .chillyWhite,
                        backgroundColor: .chillyBlack
                    ) {
                        let timestamp: Date = if let shots = self.chill.shots, !shots.isEmpty { shots[self.imageIndex].timestamp } else { .now }
                        let shot: Shot = .init(timestamp: timestamp, image: image)
                        self.action(shot)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chillyWhite)
        .task {
            let renderer = ImageRenderer(content: WelcomeBackImageView(chill: self.chill, index: self.imageIndex))

            if let uiImage = renderer.uiImage {
                self.shareImage = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    WelcomeBackView(chill: .samples[0]) { _ in }
}
