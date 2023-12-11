import Foundation
import Gateway

public struct User: Identifiable, Equatable {
    public let id: String
    public var name: String

    public init(
        id: String,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}

extension User {
    public static func fromGateway(user: Gateway.UserQuery.Data.User) -> Self {
        .init(
            id: user.id,
            name: user.name
        )
    }
}
