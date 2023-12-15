import Models
import NukeUI
import Resources
import SwiftUI

struct WelcomeBackView: View {
    private let chill: Chill
    private let action: () -> Void
    @State private var shareImage: Image?

    init(chill: Chill, action: @escaping () -> Void) {
        self.chill = chill
        self.action = action
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

                    Group {
                        if self.chill.photos.isEmpty {
                            VStack(alignment: .leading, spacing: 28) {
                                Image.iChilled
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 140)

                                ChillyIndicator(chillRate: 0.67)
                            }
                            .frame(width: 252)
                        } else {
                            ZStack {
                                LazyImage(url: self.chill.photos[0].url) { state in
                                    if let image = state.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } else if state.error != nil {
                                        VStack(alignment: .leading, spacing: 28) {
                                            Image.iChilled
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 140)
                                        }
                                        .frame(width: 252)
                                    } else {
                                        ProgressView()
                                    }
                                }

                                VStack(spacing: 0) {
                                    Spacer()

                                    ChillyIndicator(chillRate: 0.67)
                                        .frame(width: 252)

                                    Spacer()
                                        .frame(height: 22)
                                }
                            }
                        }
                    }
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
            let renderer = ImageRenderer(content: Group {
                if self.chill.photos.isEmpty {
                    VStack(alignment: .leading, spacing: 28) {
                        Image.iChilled
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)

                        ChillyIndicator(chillRate: 0.67)
                    }
                    .frame(width: 252)
                } else {
                    ZStack {
                        LazyImage(url: self.chill.photos[0].url) { state in
                            if let image = state.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else if state.error != nil {
                                VStack(alignment: .leading, spacing: 28) {
                                    Image.iChilled
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 140)
                                }
                                .frame(width: 252)
                            } else {
                                ProgressView()
                            }
                        }

                        VStack(spacing: 0) {
                            Spacer()

                            ChillyIndicator(chillRate: 0.67)
                                .frame(width: 252)

                            Spacer()
                                .frame(height: 22)
                        }
                    }
                }
            }
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
