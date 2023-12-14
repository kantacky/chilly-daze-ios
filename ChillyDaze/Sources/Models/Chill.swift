import CoreLocation
import Foundation
import Gateway

public struct Chill: Identifiable, Equatable {
    public let id: String
    public var traces: [TracePoint]
    public var photos: [Photo]
    public var newAchievements: [Achievement]

    public init(
        id: String,
        traces: [TracePoint] = [],
        photos: [Photo] = [],
        newAchievements: [Achievement] = []
    ) {
        self.id = id
        self.traces = traces
        self.photos = photos
        self.newAchievements = newAchievements
    }
}

extension Chill {
    public static func fromGateway(chill: Gateway.ChillsQuery.Data.User.Chill) throws -> Self {
        let traces: [TracePoint] = try chill.traces.map {
            try TracePoint.fromGateway(tracePoint: $0)
        }

        let photos: [Photo] = try chill.photos.map { try Photo.fromGateway(photo: $0) }

        return .init(
            id: chill.id,
            traces: traces,
            photos: photos
        )
    }

    public static func fromGateway(chill: StartChillMutation.Data.StartChill) throws -> Self {
        let traces: [TracePoint] = try chill.traces.map {
            try TracePoint.fromGateway(tracePoint: $0)
        }

        return .init(
            id: chill.id,
            traces: traces
        )
    }

    public static func fromGateway(chill: EndChillMutation.Data.EndChill) throws -> Self {
        let traces: [TracePoint] = try chill.traces.map {
            try TracePoint.fromGateway(tracePoint: $0)
        }

        let photos: [Photo] = try chill.photos.map { try Photo.fromGateway(photo: $0) }
        let newAchievements = chill.newAchievements.map { Achievement.fromGateway(achievement: $0) }

        return .init(
            id: chill.id,
            traces: traces,
            photos: photos,
            newAchievements: newAchievements
        )
    }
}

extension Chill {
    public static let sample0: Self = .init(
        id: UUID().uuidString,
        traces: [
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:00+09")!, coordinate: CLLocationCoordinate2DMake(35.681042, 139.767214)),
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:01+09")!, coordinate: CLLocationCoordinate2DMake(35.681434, 139.765729)),
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:02+09")!, coordinate: CLLocationCoordinate2DMake(35.681154, 139.765675)),
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:03+09")!, coordinate: CLLocationCoordinate2DMake(35.681333, 139.764712)),
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:04+09")!, coordinate: CLLocationCoordinate2DMake(35.680460, 139.764410)),
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:05+09")!, coordinate: CLLocationCoordinate2DMake(35.680510, 139.764105)),
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:06+09")!, coordinate: CLLocationCoordinate2DMake(35.680135, 139.764026)),
            .init(id: UUID().uuidString, timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:07+09")!, coordinate: CLLocationCoordinate2DMake(35.680176, 139.763855)),
        ]
    )

    public static let samples0: [Self] = [.sample0]
}
