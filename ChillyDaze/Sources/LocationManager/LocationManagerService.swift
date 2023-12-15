import CoreLocation
import Foundation

final class LocationManagerService: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationManagerService()

    private let locationManager: CLLocationManager

    private var coordinateChangeHandler: ((CLLocationCoordinate2D) -> Void)?
    public var coordinateStream: AsyncStream<CLLocationCoordinate2D> {
        AsyncStream { continuation in
            self.coordinateChangeHandler = { value in
                continuation.yield(value)
            }
        }
    }

    private var degreesChangeHandler: ((CLLocationDirection) -> Void)?
    public var degreesStream:  AsyncStream<CLLocationDirection> {
        AsyncStream { continuation in
            self.degreesChangeHandler = { value in
                continuation.yield(value)
            }
        }
    }

    public override init() {
        self.locationManager = .init()
        super.init()
        self.locationManager.delegate = self
        if let coordinateStream = self.coordinate {
            self.coordinateChangeHandler?(coordinateStream)
        }
        if let degreesStream = self.direction {
            self.degreesChangeHandler?(degreesStream)
        }
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 5
        self.locationManager.activityType = .fitness
    }

    public func requestWhenInUseAuthorization() -> Bool {
        if self.locationManager.authorizationStatus == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
            return true
        }

        return self.isValidAuthoriztionStatus
    }

    public var isValidAuthoriztionStatus: Bool {
        self.locationManager.authorizationStatus == .authorizedWhenInUse
            || self.locationManager.authorizationStatus == .authorizedAlways
    }

    public var coordinate: CLLocationCoordinate2D? {
        self.locationManager.location?.coordinate
    }

    public var direction: CLLocationDirection? {
        self.locationManager.heading?.magneticHeading
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let coordinate = locations.first?.coordinate {
            self.coordinateChangeHandler?(coordinate)
        }
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateHeading heading: CLHeading
    ) {
        let degrees = heading.magneticHeading
        self.degreesChangeHandler?(degrees)
    }

    public func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
    }

    public func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.stopUpdatingHeading()
    }
}
