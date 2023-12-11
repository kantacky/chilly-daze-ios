import CoreLocation
import Gateway

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

public protocol Coordinate {
    var latitude: Double { get }
    var longitude: Double { get }
}

extension CLLocationCoordinate2D {
    public static func fromGateway<T>(coordinate: T) -> Self where T: Coordinate {
        .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
