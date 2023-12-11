import Dependencies
import Foundation

extension GatewayClient: TestDependencyKey {
    public static let testValue: Self = .init()

    public static let previewValue = Self.testValue
}
