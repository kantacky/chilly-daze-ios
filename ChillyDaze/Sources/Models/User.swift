import Foundation
import Gateway

public struct User: Identifiable, Equatable {
    public let id: String
    public var name: String
    public let avatar: URL

    public init(
        id: String,
        name: String,
        avatar: URL
    ) {
        self.id = id
        self.name = name
        self.avatar = avatar
    }
}

extension User {
    public static func fromGateway(user: Gateway.UserQuery.Data.User) -> Self {
        .init(
            id: user.id,
            name: user.name,
            avatar: .init(string: user.avatar)!
        )
    }

    public static func fromGateway(user: Gateway.RegisterUserMutation.Data.RegisterUser) -> Self {
        .init(
            id: user.id,
            name: user.name,
            avatar: .init(string: user.avatar)!
        )
    }
}
