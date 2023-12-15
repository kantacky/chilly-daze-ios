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

public extension TracePoint {
    static func fromGateway(tracePoint: Gateway.ChillsQuery.Data.User.Chill.Trace) throws -> Self {
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

    static func fromGateway(tracePoint: StartChillMutation.Data.StartChill.Trace) throws -> Self {
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

    static func fromGateway(tracePoint: EndChillMutation.Data.EndChill.Trace) throws -> Self {
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

public extension TracePoint {
    static let samples: [Self] = [
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:00+09")!, coordinate: .samples[0]),
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:01+09")!, coordinate: .samples[1]),
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:02+09")!, coordinate: .samples[2]),
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:03+09")!, coordinate: .samples[3]),
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:04+09")!, coordinate: .samples[4]),
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:05+09")!, coordinate: .samples[5]),
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:06+09")!, coordinate: .samples[6]),
        .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:07+09")!, coordinate: .samples[7]),
    ]
}
