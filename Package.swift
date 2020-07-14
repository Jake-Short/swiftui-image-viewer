// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIImageViewer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ImageViewer",
            targets: ["ImageViewer"]),
        .library(
            name: "ImageViewerRemote",
            targets: ["ImageViewerRemote"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "URLImage", url: "https://github.com/dmytro-anokhin/url-image.git", from: "0.9.15")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ImageViewer",
            dependencies: ["URLImage"]),
        .target(
            name: "ImageViewerRemote",
            dependencies: [])
    ]
)
