# SceneKitDemo

A minimal iOS app demonstrating how to subclass `SCNNode` cleanly under **Swift 6 strict concurrency**.

This project was written as a companion to the Stack Overflow answer for:
[Subclassing SCNNode caused Swift 6 concurrency issues](https://stackoverflow.com/questions/79947612/subclassing-scnnode-caused-swift-6-concurrency-issues)

---

## The Problem

When a project enables Swift 6 with `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` (the Xcode default for new projects), every type that doesn't declare its own isolation is implicitly `@MainActor`. That conflicts with `SCNNode`, which is a `Sendable` Objective-C class designed to be used across threads by the SceneKit renderer. The result is a wall of concurrency errors the moment you try to subclass `SCNNode`.

## The Solution

Mark every `SCNNode` subclass `nonisolated`. This opts the class out of the ambient `@MainActor` isolation and satisfies the compiler:

```swift
nonisolated final class ShapeNode: SCNNode {
    init(geometry: SCNGeometry, color: UIColor, name: String) {
        super.init()
        self.geometry = geometry
        // ...
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}
```

`nonisolated` is the correct annotation here because:

- `SCNNode` (and the SceneKit renderer) already manage their own internal thread safety.
- Node objects are frequently created on the main thread but consumed on SceneKit's render thread — isolating them to `@MainActor` would prevent that.
- The `required init?(coder:)` stub silences a separate warning about `NSCoding` conformance under strict concurrency.

---

## Project Structure

```
SceneKitDemo/
└── SceneKitDemo/
    └── Source/
        ├── App lifecycle/
        │   ├── AppDelegate.swift
        │   └── SceneDelegate.swift
        ├── Nodes/
        │   ├── CameraNode.swift          # nonisolated SCNNode — positions the camera
        │   ├── AmbientLightNode.swift    # nonisolated SCNNode — soft fill light
        │   ├── DirectionalLightNode.swift# nonisolated SCNNode — key light with shadows
        │   ├── ShapeNode.swift           # nonisolated SCNNode — geometry + material + spin animation
        │   └── LabelNode.swift           # nonisolated SCNNode — SCNText billboard label
        ├── Resources/
        │   ├── Assets.xcassets
        │   ├── Base.lproj/
        │   │   ├── LaunchScreen.storyboard
        │   │   └── Main.storyboard
        │   └── Info.plist
        └── Views/
            └── ViewController.swift      # Sets up the SCNView and builds the scene
```

### Node types

| File | Role |
|---|---|
| `CameraNode` | Perspective camera, positioned above and back from the ring of shapes |
| `AmbientLightNode` | Low-intensity ambient fill so unlit faces aren't pure black |
| `DirectionalLightNode` | Angled key light that casts shadows |
| `ShapeNode` | Wraps a geometry + `SCNMaterial` and runs a continuous rotation action |
| `LabelNode` | Renders a `SCNText` label that always faces the camera via `SCNBillboardConstraint` |

### Build settings of note

| Setting | Value | Why |
|---|---|---|
| `SWIFT_VERSION` | `6.0` | Enables full strict concurrency checking |
| `SWIFT_DEFAULT_ACTOR_ISOLATION` | `MainActor` | All unannotated declarations are implicitly `@MainActor` — this is what triggers the issue |
| `SWIFT_APPROACHABLE_CONCURRENCY` | `YES` | Xcode 26+ ergonomic concurrency mode |

---

> This demonstration project was created with [Claude Code](https://claude.ai/code).

## License

This project is released under the [MIT License](LICENSE.md).
