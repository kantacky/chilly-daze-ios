import Models
import NukeUI
import Resources
import SwiftUI

struct WelcomeBackView: View {
    private let chill: Chill
    private let action: () -> Void
    @State private var shareImage: Image?
    @State private var imageIndex: Int
    @State private var imageView: AnyView

    init(chill: Chill, action: @escaping () -> Void) {
        self.chill = chill
        self.action = action
        self._imageIndex = .init(initialValue: 0)
        self._imageView = .init(initialValue: .init(EmptyView()))
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

                    self.imageView
                        .frame(height: UIScreen.main.bounds.width)

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
                            message: Text("I chilled 67%"),
                            preview: SharePreview("Chill", image: image)
                        )
                    }
                }

                ChillyButton(
                    labelText: "Ok",
                    foregroundColor: .chillyWhite,
                    backgroundColor: .chillyBlack
                ) {
                    self.action()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chillyWhite)
        .task {
            self.imageView = AnyView(
                Group {
                    if let images = self.chill.images,
                       !images.isEmpty {
                        ZStack {
                            images[self.imageIndex]
                                .resizable()
                                .aspectRatio(contentMode: .fill)

                            VStack(spacing: 0) {
                                Spacer()

                                ChillyIndicator(chillRate: 0.67)
                                    .frame(width: 252)

                                Spacer()
                                    .frame(height: 22)
                            }
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 28) {
                            Image.iChilled
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140)

                            ChillyIndicator(chillRate: 0.67)
                        }
                        .frame(width: 252)
                    }
                }
            )

            let renderer = ImageRenderer(content: self.imageView
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))

            if let uiImage = renderer.uiImage {
                self.shareImage = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    WelcomeBackView(chill: .samples[1]) {}
}
