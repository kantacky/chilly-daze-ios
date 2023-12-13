// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AddPhotoMutation: GraphQLMutation {
  public static let operationName: String = "AddPhoto"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddPhoto($id: ID!, $timestamp: DateTime!, $url: String!) { addPhotos(input: { id: $id, photos: [{ timestamp: $timestamp, url: $url }] }) { __typename id } }"#
    ))

  public var id: ID
  public var timestamp: DateTime
  public var url: String

  public init(
    id: ID,
    timestamp: DateTime,
    url: String
  ) {
    self.id = id
    self.timestamp = timestamp
    self.url = url
  }

  public var __variables: Variables? { [
    "id": id,
    "timestamp": timestamp,
    "url": url
  ] }

  public struct Data: Gateway.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("addPhotos", [AddPhoto].self, arguments: ["input": [
        "id": .variable("id"),
        "photos": [[
          "timestamp": .variable("timestamp"),
          "url": .variable("url")
        ]]
      ]]),
    ] }

    public var addPhotos: [AddPhoto] { __data["addPhotos"] }

    /// AddPhoto
    ///
    /// Parent Type: `Photo`
    public struct AddPhoto: Gateway.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Photo }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Gateway.ID.self),
      ] }

      public var id: Gateway.ID { __data["id"] }
    }
  }
}
