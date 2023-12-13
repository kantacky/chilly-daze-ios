// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AddTracePointMutation: GraphQLMutation {
  public static let operationName: String = "AddTracePoint"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddTracePoint($id: ID!, $timestamp: DateTime!, $latitude: Float!, $longitude: Float!) { addTracePoints( input: { id: $id, tracePoints: [{ timestamp: $timestamp, coordinate: { latitude: $latitude, longitude: $longitude } }] } ) { __typename id } }"#
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
      .field("addTracePoints", [AddTracePoint].self, arguments: ["input": [
        "id": .variable("id"),
        "tracePoints": [[
          "timestamp": .variable("timestamp"),
          "coordinate": [
            "latitude": .variable("latitude"),
            "longitude": .variable("longitude")
          ]
        ]]
      ]]),
    ] }

    public var addTracePoints: [AddTracePoint] { __data["addTracePoints"] }

    /// AddTracePoint
    ///
    /// Parent Type: `TracePoint`
    public struct AddTracePoint: Gateway.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { Gateway.Objects.TracePoint }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Gateway.ID.self),
      ] }

      public var id: Gateway.ID { __data["id"] }
    }
  }
}
