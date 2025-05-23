// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
#if canImport(PackageDescription)
import PackageDescription

#if os(Windows)
var libraryType: Product.Library.LibraryType? = .dynamic
#else
var libraryType: Product.Library.LibraryType? = nil
#endif

var settings: [SwiftSetting]? {
    var array: [SwiftSetting] = []
    
    #if false
    // A little bit faster on old hardware, but less accurate.
    // Theres no reason to use this on modern hardware.
    array.append(.define("GameMathUseFastInverseSquareRoot"))
    #endif
    
    // These settings are faster only with optimization.
    #if true
    array.append(.define("GameMathUseSIMD", .when(configuration: .release)))
    array.append(.define("GameMathUseLoopVectorization", .when(configuration: .release)))
    #endif
    
    return array.isEmpty ? nil : array
}
/*
let package = Package(
    name: "GameMath",
    products: [
        .library(name: "GameMath", type: libraryType, targets: ["GameMath"]),
    ],
    targets: [
        .target(name: "GameMath", swiftSettings: settings),
        .testTarget(name: "GameMathTests",
                    dependencies: ["GameMath"]),
    ],
    swiftLanguageVersions: [.v4]
)
*/
let package = Package(
    name: "GameMath",
//    platforms: [.macOS(.v10_15), .iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GameMath",
            targets: ["GameMath"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GameMath",
            path: "Sources/GameMath"
        )
        //        .testTarget(
        //            name: "GameMathTests",
        //            dependencies: ["GameMath"]),
    ]
)
#endif
