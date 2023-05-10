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
            targets: ["PassioRemodelAISDK"]),
    ],
    targets: [
        .binaryTarget(name: "PassioRemodelAISDK",
                      url: "https://github.com/Passiolife/Passio-Remodel-AI-iOS-SDK-Distribution/raw/main/PassioRemodelAISDK.xcframework.zip",
                      checksum: "73f4b97d05b6adf0d36d94301a819ba2c1e18e8c92c2724b7449df0207bd7582")
    ]
)
