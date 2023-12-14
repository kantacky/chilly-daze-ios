import Resources
import SwiftUI

struct ChillyAlert: View {
    private let message: String
    private let cancelAction: () -> Void
    private let cancelLabel: String
    private let primaryAction: () -> Void
    private let primaryLabel: String

    init(
        message: String,
        cancelAction: @escaping () -> Void,
        cancelLabel: String = "キャンセル",
        primaryAction: @escaping () -> Void,
        primaryLabel: String
    ) {
        Font.registerCustomFonts()
        self.message = message
        self.cancelAction = cancelAction
        self.cancelLabel = cancelLabel
        self.primaryAction = primaryAction
        self.primaryLabel = primaryLabel
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(self.message)
                .frame(height: 47)

            Rectangle()
                .fill(Color.chillyBlack)
                .frame(height: 2)

            HStack(spacing: 0) {
                Button {
                    self.cancelAction()
                } label: {
                    Text(self.cancelLabel)
                }
                .frame(width: 147)

                Rectangle()
                    .fill(Color.chillyBlack)
                    .frame(width: 2)

                Button {
                    self.primaryAction()
                } label: {
                    Text(self.primaryLabel)
                        .font(.customFont(.zenKakuGothicAntiqueBlack, size: 17))
                }
                .frame(width: 147)
            }
            .frame(height: 47)
        }
        .tint(Color.chillyBlack)
        .font(.customFont(.zenKakuGothicAntiqueMedium, size: 17))
        .background(Color.chillyWhite)
        .frame(width: 300, height: 100)
        .border(Color.chillyBlack, width: 2)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.chillyBackground)

    }
}

#Preview {
    ChillyAlert(
        message: "アクティビティを終了しますか？",
        cancelAction: {},
        primaryAction: {},
        primaryLabel: "終了"
    )
}
