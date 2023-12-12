import Achievement
import ChillMap
import Foundation
import Record
import SwiftUI

extension MainReducer.State: Identifiable, CaseIterable {
    public var id: UUID {
        .init()
    }

    public static var allCases: [MainReducer.State] {
        [
            .chillMap(.init()),
            .record(.init()),
            .achievement(.init()),
        ]
    }

    func tabImage(isSelected: Bool) -> Image {
        switch self {
        case .chillMap:
            return Image(systemName: isSelected ? "house.fill" : "house")

        case .record:
            return Image(systemName: isSelected ? "book.pages.fill" : "book.pages")

        case .achievement:
            return Image(systemName: isSelected ? "star.circle.fill" : "star.circle")
        }
    }
}
