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
    public static let sample0: Self = .init(id: UUID().uuidString)
}
