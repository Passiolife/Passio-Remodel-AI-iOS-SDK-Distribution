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
                      checksum: "123ad8036003e58b26ee14bbb528e7b80cb59380419218d43a3dfedf51d6b44e")
    ]
)
