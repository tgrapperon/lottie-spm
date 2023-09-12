// swift-tools-version:5.6

import PackageDescription

#if swift(>=5.9)
/// A precompiled XCFramework of the lottie-ios repo that was compiled with Xcode 15.0
let lottieXCFramework = Target.binaryTarget(
  name: "Lottie",
  path: "Lottie-Xcode-15.0.xcframework")
#else
/// A precompiled XCFramework of the lottie-ios repo that was compiled with Xcode 13.4.1
let lottieXCFramework: Target.binaryTarget(
  name: "Lottie",
  path: "Lottie-Xcode-13.4.1.xcframework")
#endif


let package = Package(
  name: "Lottie",
  platforms: [.iOS("11.0"), .macOS("10.11"), .tvOS("11.0"), .custom("visionOS", versionString: "1.0")],
  products: [.library(name: "Lottie", targets: ["Lottie", "_LottieStub"])],
  targets: [
    lottieXCFramework,
    
    // Without at least one regular (non-binary) target, this package doesn't show up
    // in Xcode under "Frameworks, Libraries, and Embedded Content". That prevents
    // Lottie from being embedded in the app product, causing the app to crash when
    // ran on a physical device. As a workaround, we can include a stub target
    // with at least one source file.
    .target(name: "_LottieStub"),
    
    .testTarget(
      name: "LottieTests",
      dependencies: ["Lottie"],
      path: "Tests")
  ])
