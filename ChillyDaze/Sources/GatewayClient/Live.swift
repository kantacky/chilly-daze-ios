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
        endChill: {
            id,
            tracePoints,
            photos in

            try await Implement.endChill(
                id: id,
                tracePoints: tracePoints,
                photos: photos
            )
        }
    )
}
