import Resources
import SwiftUI

enum ButtonCategory {
    case start
    case stop
    case camera

    var labelText: String? {
        switch self {
        case .start:
            return "Start"

        case .stop:
            return "Stop"

        default:
            return nil
        }
    }

    var labelImage: Image {
        switch self {
        case .start:
            return Image(systemName: "play.fill")

        case .stop:
            return Image(systemName: "stop.fill")

        case .camera:
            return Image(systemName: "camera.fill")
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

                buttonCategory.labelImage
            }
            .font(.customFont(.inikaBold, size: 20))
            .padding(.vertical, buttonCategory == .camera ? 15 : 14)
            .padding(.horizontal, buttonCategory == .camera ? 16 : 40)
            .tint(Color.chillyBlack)
            .background(Color.chillyYellow)
            .border(Color.chillyBlack, width: 2)
        }
    }
}

#Preview {
    VStack(spacing: 64) {
        ChillyButton(buttonCategory: .start) {
            print("Start")
        }

        HStack(spacing: 16.5) {
            ChillyButton(buttonCategory: .stop) {
                print("Stop")
            }

            ChillyButton(buttonCategory: .camera) {
                print("Camera")
            }
        }
    }
}
