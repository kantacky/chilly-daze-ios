import Foundation
import Gateway

public struct User: Identifiable, Equatable {
    public let id: String
    public var name: String
    public let avatar: String?

    public init(
        id: String,
        name: String,
        avatar: String? = nil
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
            avatar: user.avatar?.name
        )
    }

    public static func fromGateway(user: Gateway.RegisterUserMutation.Data.RegisterUser) -> Self {
        .init(
            id: user.id,
            name: user.name,
            avatar: user.avatar?.name
        )
    }
}

extension User {
    public static let sample0: Self = .init(
        id: UUID().uuidString,
        name: "John Due"
    )
}
