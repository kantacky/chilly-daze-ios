// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ChillyDaze",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Achievement", targets: ["Achievement"]),
        .library(name: "ChillMap", targets: ["ChillMap"]),
        .library(name: "ChillyDaze", targets: ["ChillyDaze"]),
        .library(name: "Record", targets: ["Record"]),
        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "SignIn", targets: ["SignIn"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", .upToNextMajor(from: "20.0.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "10.19.0")),
        .package(url: "https://github.com/kean/Nuke.git", .upToNextMajor(from: "12.2.0")),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.1.0")),
        .package(path: "../Gateway"),
    ],
    targets: [
        .target(
            name: "Achievement",
            dependencies: [
                "AuthClient",
                "GatewayClient",
                "Resources",
                .composableArchitecture,
                .nukeUI,
            ]
        ),
        .target(
            name: "AuthClient",
            dependencies: [
                .dependencies,
                .firebaseAuth,
                .keychainSwift,
            ]
        ),
        .target(
            name: "ChillMap",
            dependencies: [
                "GatewayClient",
                "LocationManager",
                "Resources",
                .composableArchitecture,
            ]
        ),
        .target(
            name: "ChillyDaze",
            dependencies: [
                "Achievement",
                "AuthClient",
                "ChillMap",
                "LocationManager",
                "Record",
                "Resources",
                "SignIn",
                .composableArchitecture,
                .firebaseAuth,
            ],
            resources: [
                .process("./Resources"),
            ]
        ),
        .target(
            name: "GatewayClient",
            dependencies: [
                "Gateway",
                "Models",
                .apollo,
                .dependencies,
                .keychainSwift,
            ]
        ),
        .target(
            name: "LocationManager",
            dependencies: [
                "Models",
                .dependencies,
            ]
        ),
        .target(
            name: "Models",
            dependencies: [
                "Gateway",
            ]
        ),
        .target(
            name: "Record",
            dependencies: [
                "Resources",
                .composableArchitecture,
            ]
        ),
        .target(
            name: "Resources",
            resources: [
                .process("./Resources")
            ]
        ),
        .target(
            name: "SignIn",
            dependencies: [
                "AuthClient",
                "GatewayClient",
                "Resources",
                .composableArchitecture,
            ]
        ),
        .testTarget(
            name: "ChillyDazeTests",
            dependencies: [
                "ChillyDaze",
                .composableArchitecture,
            ]
        ),
        .testTarget(
            name: "SignInTests",
            dependencies: [
                "SignIn",
                .composableArchitecture,
            ]
        ),
    ]
)

extension Target.Dependency {
    static var apollo: Self { .product(name: "Apollo", package: "apollo-ios") }
    static var composableArchitecture: Self { .product(name: "ComposableArchitecture", package: "swift-composable-architecture") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var nukeUI: Self { .product(name: "NukeUI", package: "nuke") }
    static var firebaseAnalytics: Self { .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk") }
    static var firebaseAuth: Self { .product(name: "FirebaseAuth", package: "firebase-ios-sdk") }
    static var keychainSwift: Self { .product(name: "KeychainSwift", package: "keychain-swift") }
}

extension Target.PluginUsage {}
