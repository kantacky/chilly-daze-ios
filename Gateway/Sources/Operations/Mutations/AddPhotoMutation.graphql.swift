// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AddPhotoMutation: GraphQLMutation {
  public static let operationName: String = "AddPhoto"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddPhoto($id: ID!, $url: String!) { addPhotos(input: { id: $id, photos: [{ url: $url }] }) { __typename id } }"#
    ))

  public var id: ID
  public var url: String

  public init(
    id: ID,
    url: String
  ) {
    self.id = id
    self.url = url
  }

  public var __variables: Variables? { [
    "id": id,
    "url": url
  ] }

  public struct Data: Gateway.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("addPhotos", AddPhotos.self, arguments: ["input": [
        "id": .variable("id"),
        "photos": [["url": .variable("url")]]
      ]]),
    ] }

    public var addPhotos: AddPhotos { __data["addPhotos"] }

    /// AddPhotos
    ///
    /// Parent Type: `Chill`
    public struct AddPhotos: Gateway.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Chill }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Gateway.ID.self),
      ] }

      public var id: Gateway.ID { __data["id"] }
    }
  }
}
