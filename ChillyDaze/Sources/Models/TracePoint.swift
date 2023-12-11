import CoreLocation
import Foundation
import Gateway

public struct TracePoint: Identifiable, Equatable {
    public let id: String
    public let timestamp: Date
    public let coordinate: CLLocationCoordinate2D

    public init(
        id: String,
        timestamp: Date,
        coordinate: CLLocationCoordinate2D
    ) {
        self.id = id
        self.timestamp = timestamp
        self.coordinate = coordinate
    }
}

extension TracePoint {
    public static func fromGateway(tracePoint: Gateway.ChillsQuery.Data.User.Chill.Trace) throws -> Self {
        guard let timestamp = Formatter.iso8601.date(from: tracePoint.timestamp) else {
            throw ModelsError.invalidDateStringFormat
        }

        return .init(
            id: tracePoint.id,
            timestamp: timestamp,
            coordinate: .init(
                latitude: tracePoint.coordinate.latitude,
                longitude: tracePoint.coordinate.longitude
            )
        )
    }
}
