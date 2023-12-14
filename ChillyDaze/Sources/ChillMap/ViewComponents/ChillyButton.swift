import Resources
import SwiftUI

enum ButtonCategory {
    case start
    case stop
    case ok
    case camera
    case share

    var labelText: String? {
        switch self {
        case .start:
            return "Start"

        case .stop:
            return "Stop"

        case .ok:
            return "Ok"

        default:
            return nil
        }
    }

    var labelImage: Image? {
        switch self {
        case .start:
            return Image(systemName: "play.fill")

        case .stop:
            return Image(systemName: "stop.fill")

        case .camera:
            return Image(systemName: "camera.fill")

        case .share:
            return Image(systemName: "square.and.arrow.up")

        default:
            return nil
        }
    }
}

struct ChillyButton: View {
    private var buttonCategory: ButtonCategory
    private var action: () -> Void

    init(buttonCategory: ButtonCategory, action: @escaping () -> Void) {
        Font.registerCustomFonts()
        self.buttonCategory = buttonCategory
        self.action = action
    }

    var body: some View {
        Button(action: self.action) {
            HStack {
                if let labelText = buttonCategory.labelText {
                    Text(labelText)
                }

                if let labelImage = buttonCategory.labelImage {
                    labelImage
                }
            }
            .font(.customFont(.inikaBold, size: 20))
            .padding(.horizontal, buttonCategory.labelText == nil ? 16 : 40)
            .tint(buttonCategory == .ok ? Color.chillyWhite : Color.chillyBlack)
            .frame(height: 54)
            .background(buttonCategory == .ok ? Color.chillyBlack : Color.chillyYellow)
            .border(Color.chillyBlack, width: 2)
        }
    }
}

#Preview {
    VStack(spacing: 64) {
        ChillyButton(buttonCategory: .start) {}

        HStack(spacing: 16.5) {
            ChillyButton(buttonCategory: .stop) {}

            ChillyButton(buttonCategory: .camera) {}
        }

        HStack(spacing: 16.5) {
            ChillyButton(buttonCategory: .share) {}

            ChillyButton(buttonCategory: .ok) {}
        }
    }
}
