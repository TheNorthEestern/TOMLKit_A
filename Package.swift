// swift-tools-version:6.0

import PackageDescription

let package = Package(
	name: "TOMLKit",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13),
		.watchOS(.v6),
		.tvOS(.v18),
	],
	products: [
		.library(name: "TOMLKit", targets: ["TOMLKit"]),
	],
	dependencies: [
		// Use this dependency when one of the `TOMLTable` comparison tests fail and
		// XCTAssertEqual tells you "<huge TOMLTable> is not equal to <other huge TOMLTable>"
		// .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "0.1.0"),
		.package(name: "Checkit", url: "https://github.com/karwa/swift-checkit.git", from: "0.0.2"),
	],
	targets: [
		.target(
			name: "CTOML",
			cxxSettings: [
				.define("TOML_EXCEPTIONS", to: "1"),
				.define("_CRT_NONSTDC_NO_WARNINGS", .when(platforms: [.windows])),
			]
		),
		.target(
			name: "TOMLKit",
			dependencies: ["CTOML"],
			exclude: ["TOMLKit.docc"]
		),
		.testTarget(
			name: "TOMLKitTests",
			dependencies: [
				"TOMLKit",
				.product(name: "Checkit", package: "Checkit"), /* .product(name: "CustomDump", package: "swift-custom-dump") */
			]
		),
	],
	cLanguageStandard: .c99,
	cxxLanguageStandard: .cxx17
)

#if swift(>=5.6) && !os(Windows)
	package.dependencies.append(
		.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
	)
#endif
