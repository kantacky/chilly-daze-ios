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

public extension Photo {
    static func fromGateway(photo: Gateway.ChillsQuery.Data.User.Chill.Photo) throws -> Self {
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

    static func fromGateway(photo: EndChillMutation.Data.EndChill.Photo) throws -> Self {
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

public extension Photo {
    static let samples: [Self] = [
        .init(
            id: UUID().uuidString,
            timestamp: Formatter.iso8601.date(from: "2023-12-01T09:00:00+09")!,
            url: .init(string: "https://lh3.googleusercontent.com/p/AF1QipPKN3tLkBVnAxUOisz-vA1qhF0RIDV1Bj_PK1xn=s1360-w1360-h1020")!
        )
    ]
}
