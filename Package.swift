import PackageDescription

let package = Package(
	name: "ESDTMF",
    targets: [
        Target(name: "ESDTMF", dependencies: ["ESAudio"])
    ]
)
