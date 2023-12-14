import Resources
import SwiftUI

struct ChillyIndicator: View {
    private var chillRate: CGFloat

    init(chillRate: CGFloat) {
        Font.registerCustomFonts()
        self.chillRate = chillRate
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.chillyBlue)
                        .frame(width: geometry.size.width * chillRate)

                    Rectangle()
                        .fill(Color.chillyYellow)
                        .frame(width: geometry.size.width * (1 - chillRate))
                }
                .frame(height: 42)
                .border(Color.chillyBlack, width: 2)

                Image.indicatorPin
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .offset(x: geometry.size.width * (self.chillRate - 0.5))

                HStack(spacing: 0) {
                    if chillRate >= 0.5 {
                        Text("\(Int(chillRate * 100))%")
                            .font(.customFont(.inikaRegular, size: 20))
                            .foregroundStyle(Color.chillyWhite)

                        Spacer()
                    } else {
                        Spacer()

                        Text("\(Int(chillRate * 100))%")
                            .font(.customFont(.inikaRegular, size: 20))
                            .foregroundStyle(Color.chillyBlack)
                    }
                }
                .padding(.horizontal, 14)
            }
        }
    }
}

#Preview {
    VStack {
        ChillyIndicator(chillRate: 0.03)

        ChillyIndicator(chillRate: 0.23)

        ChillyIndicator(chillRate: 0.43)

        ChillyIndicator(chillRate: 0.50)

        ChillyIndicator(chillRate: 0.67)

        ChillyIndicator(chillRate: 0.88)

        ChillyIndicator(chillRate: 0.98)
    }
    .frame(width: 252)
}
