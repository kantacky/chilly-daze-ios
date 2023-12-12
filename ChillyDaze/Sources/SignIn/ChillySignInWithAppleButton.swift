import SwiftUI

struct ChillySignInWithAppleButton: View {
    private var action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button(action: self.action) {
            HStack(spacing: 10) {
                Image(systemName: "applelogo")
                Text("Sign in with Apple")
            }
            .font(.system(size: 20, weight: .medium, design: .monospaced))
            .kerning(-0.8)
            .padding(.vertical, 14)
            .padding(.horizontal, 40)
            .tint(Color(.chillyWhite))
            .background(Color(.chillyBlack))
        }
    }
}

#Preview {
    ChillySignInWithAppleButton {
        print("ChillySignInWithAppleButton")
    }
}
