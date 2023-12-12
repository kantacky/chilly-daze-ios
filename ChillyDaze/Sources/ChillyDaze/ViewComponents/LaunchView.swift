import SwiftUI

struct LaunchView: View {
    var body: some View {
        Image(.appIcon)
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.chillyYellow))
    }
}

#Preview {
    LaunchView()
}
