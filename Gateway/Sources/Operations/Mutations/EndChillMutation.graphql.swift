// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EndChillMutation: GraphQLMutation {
  public static let operationName: String = "EndChill"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation EndChill($id: ID!, $timestamp: DateTime!, $latitude: Float!, $longitude: Float!) { endChill( input: { id: $id, timestamp: $timestamp, coordinate: { latitude: $latitude, longitude: $longitude } } ) { __typename id traces { __typename id timestamp coordinate { __typename latitude longitude } } photos { __typename id timestamp url } } }"#
    ))

  public var id: ID
  public var timestamp: DateTime
  public var latitude: Double
  public var longitude: Double

  public init(
    id: ID,
    timestamp: DateTime,
    latitude: Double,
    longitude: Double
  ) {
    self.id = id
    self.timestamp = timestamp
    self.latitude = latitude
    self.longitude = longitude
  }

  public var __variables: Variables? { [
    "id": id,
    "timestamp": timestamp,
    "latitude": latitude,
    "longitude": longitude
  ] }

  public struct Data: Gateway.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("endChill", EndChill.self, arguments: ["input": [
        "id": .variable("id"),
        "timestamp": .variable("timestamp"),
        "coordinate": [
          "latitude": .variable("latitude"),
          "longitude": .variable("longitude")
        ]
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
      ] }

      public var id: Gateway.ID { __data["id"] }
      public var traces: [Trace] { __data["traces"] }
      public var photos: [Photo] { __data["photos"] }

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
    }
  }
}
