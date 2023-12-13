import Foundation
import Gateway

public struct Chill: Identifiable, Equatable {
    public let id: String
    public var traces: [TracePoint]
    public var photos: [Photo]

    public init(
        id: String,
        traces: [TracePoint] = [],
        photos: [Photo] = []
    ) {
        self.id = id
        self.traces = traces
        self.photos = photos
    }
}

extension Chill {
    public static func fromGateway(chill: Gateway.ChillsQuery.Data.User.Chill) throws -> Self {
        let traces: [TracePoint] = try chill.traces.map {
            try TracePoint.fromGateway(tracePoint: $0)
        }

        let photos: [Photo] = try chill.photos.map { try Photo.fromGateway(photo: $0) }

        return .init(id: chill.id, traces: traces, photos: photos)
    }

    public static func fromGateway(chill: StartChillMutation.Data.StartChill) throws -> Self {
        let traces: [TracePoint] = try chill.traces.map {
            try TracePoint.fromGateway(tracePoint: $0)
        }

        let photos: [Photo] = try chill.photos.map { try Photo.fromGateway(photo: $0) }

        return .init(id: chill.id, traces: traces, photos: photos)
    }

    public static func fromGateway(chill: EndChillMutation.Data.EndChill) throws -> Self {
        let traces: [TracePoint] = try chill.traces.map {
            try TracePoint.fromGateway(tracePoint: $0)
        }

        let photos: [Photo] = try chill.photos.map { try Photo.fromGateway(photo: $0) }

        return .init(id: chill.id, traces: traces, photos: photos)
    }
}
