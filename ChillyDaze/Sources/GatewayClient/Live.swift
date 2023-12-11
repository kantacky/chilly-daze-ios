import Dependencies
import Foundation
import Gateway

extension GatewayClient: DependencyKey {
    public static let liveValue: Self = .init()
}
