import Dependencies
import Foundation

extension LocationManager: TestDependencyKey {
    public static let testValue: Self = .init(
        getCurrentLocation: unimplemented("\(Self.self)"),
        getLocationStream: unimplemented("\(Self.self)"),
        startUpdatingLocation: unimplemented("\(Self.self)"),
        stopUpdatingLocation: unimplemented("\(Self.self)")
    )

    public static let previewValue = Self.testValue
}
