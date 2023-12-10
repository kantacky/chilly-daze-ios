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
    ],
    targets: [
        .target(name: "ChillyDaze"),
        .testTarget(
            name: "ChillyDazeTests",
            dependencies: [
                "ChillyDaze",
            ]
        ),
    ]
)
