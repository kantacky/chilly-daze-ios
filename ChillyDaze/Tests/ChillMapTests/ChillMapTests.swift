import ComposableArchitecture
import XCTest

@testable import ChillMap

@MainActor
final class ChillMapTests: XCTestCase {
    typealias Reducer = ChillMap

    func testOnAppear() async {
        let store: TestStore = .init(initialState: Reducer.State()) {
            Reducer()
        } withDependencies: {
            $0.locationManager = .testValue
            $0.gatewayClient = .testValue
        }
    }
}
