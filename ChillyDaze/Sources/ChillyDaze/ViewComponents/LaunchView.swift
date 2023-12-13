import SwiftUI

struct LaunchView: View {
    var body: some View {
        Image(.appIcon)
            .resizable()
            .scaledToFit()
            .frame(width: 300)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.chillyWhite))
    }
}

#Preview {
    LaunchView()
}
