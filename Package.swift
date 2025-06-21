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
                      checksum: "8e8128be285eb9dcc8c6c80cbbfd792a4288470c57b50b8ba96fca1b1ca2633b")
    ]
)
