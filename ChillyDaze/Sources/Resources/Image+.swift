import SwiftUI

public extension Image {
    static let appIcon: Self = .init(.appIcon)
    static let chillyDaze: Self = .init(.chillyDaze)
    static let readyToExploreChillyDaze: Self = .init(.readyToExploreChillyDaze)

    enum Achievement {}
    enum Banner {}
}

public extension Image.Achievement {
    static let achievementDefault: Image = .init(.Achievement.default)
}

public extension Image.Banner {
    static let area: Image = .init(.Banner.area)
    static let frequence: Image = .init(.Banner.frequency)
}
