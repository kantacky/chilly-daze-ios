import Dependencies
import Foundation

extension GatewayClient: DependencyKey {
    public static let liveValue: Self = .init(
        registerUser: { name, avatar in
            try await Implement.registerUser(name: name, avatar: avatar)
        },
        getUser: {
            try await Implement.getUser()
        },
        getChills: {
            try await Implement.getChills()
        },
        getAchievements: {
            try await Implement.getAchievements()
        },
        getUserAchievements: {
            try await Implement.getUserAchievements()
        },
        startChill: {
            timestamp,
            latitude,
            longitude in

            try await Implement.startChill(
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude
            )
        },
        addTracePoint: {
            id,
            timestamp,
            latitude,
            longitude in

            try await Implement.addTracePoint(
                id: id,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude
            )
        },
        addPhoto: { id, timestamp, url in
            try await Implement.addPhoto(id: id, timestamp: timestamp, url: url)
        },
        endChill: {
            id,
            timestamp,
            latitude,
            longitude in

            try await Implement.endChill(
                id: id,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude
            )
        }
    )
}
