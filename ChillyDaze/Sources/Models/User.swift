import Foundation
import Gateway

public struct User: Identifiable, Equatable {
    public let id: String
    public var name: String
    public let avatar: URL?

    public init(
        id: String,
        name: String,
        avatar: URL?
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
            avatar: .init(string: user.avatar)
        )
    }

    public static func fromGateway(user: Gateway.RegisterUserMutation.Data.RegisterUser) -> Self {
        .init(
            id: user.id,
            name: user.name,
            avatar: .init(string: user.avatar)
        )
    }
}

extension User {
    public static let sample0: Self = .init(
        id: UUID().uuidString,
        name: "John Due",
        avatar: URL(string: "https://firebasestorage.googleapis.com/v0/b/chilly-daze.appspot.com/o/avatar%2Fexample%2FAppIcon.png?alt=media&token=3f9a5cad-a1de-4e4a-b1f1-59bad9a182b3")!
    )
}
