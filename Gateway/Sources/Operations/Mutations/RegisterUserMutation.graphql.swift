// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RegisterUserMutation: GraphQLMutation {
  public static let operationName: String = "RegisterUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RegisterUser($name: String!, $avatar: String!) { registerUser(input: { name: $name, avatar: $avatar }) { __typename id name avatar { __typename name } } }"#
    ))

  public var name: String
  public var avatar: String

  public init(
    name: String,
    avatar: String
  ) {
    self.name = name
    self.avatar = avatar
  }

  public var __variables: Variables? { [
    "name": name,
    "avatar": avatar
  ] }

  public struct Data: Gateway.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("registerUser", RegisterUser.self, arguments: ["input": [
        "name": .variable("name"),
        "avatar": .variable("avatar")
      ]]),
    ] }

    public var registerUser: RegisterUser { __data["registerUser"] }

    /// RegisterUser
    ///
    /// Parent Type: `User`
    public struct RegisterUser: Gateway.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Gateway.ID.self),
        .field("name", String.self),
        .field("avatar", Avatar?.self),
      ] }

      public var id: Gateway.ID { __data["id"] }
      public var name: String { __data["name"] }
      public var avatar: Avatar? { __data["avatar"] }

      /// RegisterUser.Avatar
      ///
      /// Parent Type: `Achievement`
      public struct Avatar: Gateway.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Achievement }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
        ] }

        public var name: String { __data["name"] }
      }
    }
  }
}
