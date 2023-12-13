import Foundation
import Gateway

public struct Photo: Identifiable, Equatable {
    public let id: String
    public let timestamp: Date
    public let url: URL

    public init(
        id: String,
        timestamp: Date,
        url: URL
    ) {
        self.id = id
        self.timestamp = timestamp
        self.url = url
    }
}

extension Photo {
    public static func fromGateway(photo: Gateway.ChillsQuery.Data.User.Chill.Photo) throws -> Self {
        guard let timestamp = Formatter.iso8601.date(from: photo.timestamp) else {
            throw ModelsError.invalidDateStringFormat
        }

        guard let url = URL(string: photo.url) else {
            throw ModelsError.invalidURLString
        }

        return .init(
            id: photo.id,
            timestamp: timestamp,
            url: url
        )
    }

    public static func fromGateway(photo: EndChillMutation.Data.EndChill.Photo) throws -> Self {
        guard let timestamp = Formatter.iso8601.date(from: photo.timestamp) else {
            throw ModelsError.invalidDateStringFormat
        }

        guard let url = URL(string: photo.url) else {
            throw ModelsError.invalidURLString
        }

        return .init(
            id: photo.id,
            timestamp: timestamp,
            url: url
        )
    }
}
