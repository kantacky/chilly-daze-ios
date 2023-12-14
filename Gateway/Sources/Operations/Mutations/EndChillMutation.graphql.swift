// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EndChillMutation: GraphQLMutation {
  public static let operationName: String = "EndChill"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation EndChill($id: ID!, $tracePoints: [TracePointInput!]!, $photos: [PhotoInput!]!, $timestamp: DateTime!) { endChill( input: { id: $id, tracePoints: $tracePoints, photos: $photos, timestamp: $timestamp } ) { __typename id traces { __typename id timestamp coordinate { __typename latitude longitude } } photos { __typename id timestamp url } newAchievements { __typename id name displayName description category { __typename id name displayName } } } }"#
    ))

  public var id: ID
  public var tracePoints: [TracePointInput]
  public var photos: [PhotoInput]
  public var timestamp: DateTime

  public init(
    id: ID,
    tracePoints: [TracePointInput],
    photos: [PhotoInput],
    timestamp: DateTime
  ) {
    self.id = id
    self.tracePoints = tracePoints
    self.photos = photos
    self.timestamp = timestamp
  }

  public var __variables: Variables? { [
    "id": id,
    "tracePoints": tracePoints,
    "photos": photos,
    "timestamp": timestamp
  ] }

  public struct Data: Gateway.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("endChill", EndChill.self, arguments: ["input": [
        "id": .variable("id"),
        "tracePoints": .variable("tracePoints"),
        "photos": .variable("photos"),
        "timestamp": .variable("timestamp")
      ]]),
    ] }

    public var endChill: EndChill { __data["endChill"] }

    /// EndChill
    ///
    /// Parent Type: `Chill`
    public struct EndChill: Gateway.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Chill }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Gateway.ID.self),
        .field("traces", [Trace].self),
        .field("photos", [Photo].self),
        .field("newAchievements", [NewAchievement].self),
      ] }

      public var id: Gateway.ID { __data["id"] }
      public var traces: [Trace] { __data["traces"] }
      public var photos: [Photo] { __data["photos"] }
      public var newAchievements: [NewAchievement] { __data["newAchievements"] }

      /// EndChill.Trace
      ///
      /// Parent Type: `TracePoint`
      public struct Trace: Gateway.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.TracePoint }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Gateway.ID.self),
          .field("timestamp", Gateway.DateTime.self),
          .field("coordinate", Coordinate.self),
        ] }

        public var id: Gateway.ID { __data["id"] }
        public var timestamp: Gateway.DateTime { __data["timestamp"] }
        public var coordinate: Coordinate { __data["coordinate"] }

        /// EndChill.Trace.Coordinate
        ///
        /// Parent Type: `Coordinate`
        public struct Coordinate: Gateway.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Coordinate }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("latitude", Double.self),
            .field("longitude", Double.self),
          ] }

          public var latitude: Double { __data["latitude"] }
          public var longitude: Double { __data["longitude"] }
        }
      }

      /// EndChill.Photo
      ///
      /// Parent Type: `Photo`
      public struct Photo: Gateway.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Photo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Gateway.ID.self),
          .field("timestamp", Gateway.DateTime.self),
          .field("url", String.self),
        ] }

        public var id: Gateway.ID { __data["id"] }
        public var timestamp: Gateway.DateTime { __data["timestamp"] }
        public var url: String { __data["url"] }
      }

      /// EndChill.NewAchievement
      ///
      /// Parent Type: `Achievement`
      public struct NewAchievement: Gateway.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Achievement }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", Gateway.ID.self),
          .field("name", String.self),
          .field("displayName", String.self),
          .field("description", String.self),
          .field("category", Category.self),
        ] }

        public var id: Gateway.ID { __data["id"] }
        public var name: String { __data["name"] }
        public var displayName: String { __data["displayName"] }
        public var description: String { __data["description"] }
        public var category: Category { __data["category"] }

        /// EndChill.NewAchievement.Category
        ///
        /// Parent Type: `AchievementCategory`
        public struct Category: Gateway.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.AchievementCategory }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Gateway.ID.self),
            .field("name", String.self),
            .field("displayName", String.self),
          ] }

          public var id: Gateway.ID { __data["id"] }
          public var name: String { __data["name"] }
          public var displayName: String { __data["displayName"] }
        }
      }
    }
  }
}
