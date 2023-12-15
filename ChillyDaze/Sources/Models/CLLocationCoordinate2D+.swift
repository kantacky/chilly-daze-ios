import CoreLocation
import Gateway

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

public extension CLLocationCoordinate2D {
    var location: CLLocation {
        .init(latitude: self.latitude, longitude: self.longitude)
    }
}
