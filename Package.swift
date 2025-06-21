// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassioRemodelAISDK",
    platforms: [.iOS(.v13)
    ],
    products: [
        .library(
            name: "PassioRemodelAISDK",
            targets: ["PassioRemodelAISDK"])
    ],
    targets: [
        .binaryTarget(name: "PassioRemodelAISDK",
                      url: "https://github.com/Passiolife/Passio-Remodel-AI-iOS-SDK-Distribution/raw/main/PassioRemodelAISDK.xcframework.zip",
                      checksum: "725eb15bfe00282a2c590d651f58fba97b8878a07d7fd42b39f454f8b6cd5e13")
    ]
)
