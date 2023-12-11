import Foundation
import Gateway

public struct Photo: Identifiable, Equatable {
    public let id: String
    public let url: URL
    public let timestamp: Date

    init(
        id: String,
        url: URL,
        timestamp: Date
    ) {
        self.id = id
        self.url = url
        self.timestamp = timestamp
    }
}

extension Photo {
    public static func fromGateway(photo: Gateway.ChillsQuery.Data.User.Chill.Photo) throws -> Self {
        guard let url = URL(string: photo.url) else {
            throw ModelsError.invalidURLString
        }

        guard let timestamp = Formatter.iso8601.date(from: photo.timestamp) else {
            throw ModelsError.invalidDateStringFormat
        }

        return .init(
            id: photo.id,
            url: url,
            timestamp: timestamp
        )
    }
}
