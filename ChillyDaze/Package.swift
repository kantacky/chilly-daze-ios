// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ChillyDaze",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "ChillyDaze", targets: ["ChillyDaze"]),
        .library(name: "SignIn", targets: ["SignIn"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "10.19.0")),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.1.0")),
    ],
    targets: [
        .target(
            name: "ChillyDaze",
            dependencies: [
                "FirebaseAuthClient",
                "SignIn",
                .composableArchitecture,
                .firebaseAuth,
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "FirebaseAuthClient",
            dependencies: [
                .dependencies,
                .firebaseAuth,
            ]
        ),
        .target(
            name: "SignIn",
            dependencies: [
                "FirebaseAuthClient",
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
    static var composableArchitecture: Self { .product(name: "ComposableArchitecture", package: "swift-composable-architecture") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var firebaseAnalytics: Self { .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk") }
    static var firebaseAuth: Self { .product(name: "FirebaseAuth", package: "firebase-ios-sdk") }
}

extension Target.PluginUsage {}
