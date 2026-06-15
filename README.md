# ScoopCardlink — Swift Package (binary distribution)

Public Swift Package Manager distribution of the **ScoopCardlink** iOS SDK — NFC-based
German health‑card (eGK) authentication and eHealth flows (CardLink, PoPP check‑in,
eRezept). This repo hosts only `Package.swift` + the `ScoopCardlink.xcframework` release
binary; the SDK source stays in the private [`scoop-software/cardlink-sdk`](https://github.com/scoop-software/cardlink-sdk) repo.

> **Current release: 2.1.2** · iOS 14+ · **Xcode 26+** · Apple‑Silicon simulator only

## Install

```swift
.package(url: "https://github.com/scoop-software/cardlink-sdk-spm.git", from: "2.1.2")
```

…or in Xcode: **File → Add Package Dependencies…** and paste the URL above.

## Required build settings (Xcode 26)

The framework ships a binary `.swiftmodule` (no library evolution). On the target that
imports `ScoopCardlink`, set:

| Setting | Value | Why |
| ------- | ----- | --- |
| `SWIFT_ENABLE_EXPLICIT_MODULES` | `NO` | Xcode 26's explicit‑module build otherwise rebuilds the framework interface and drops the SDK's Swift types (`cannot find type 'ErezeptType'…`). |
| `EXCLUDED_ARCHS[sdk=iphonesimulator*]` | `x86_64` | The simulator slice is arm64 only (Apple Silicon). |

The binary is tied to its build's Swift compiler — **use Xcode 26.x** (it is rebuilt and
re‑released per Xcode major version).

## Usage

```swift
import ScoopCardlink
```

API documentation is available inline in Xcode as **Quick Help** (⌥‑click any symbol).
For a complete, runnable integration (CardLink flow, PoPP check‑in, eRezept upload/delete),
see the demo app: **[scoop-software/cardlink-sdk-demos](https://github.com/scoop-software/cardlink-sdk-demos)** (`ios/`).

> NFC features require a **physical device** with NFC, the NFC entitlement, and the
> ISO 7816 / reader‑session keys in your target's `Info.plist`.

## Versioning

Tags (`v2.1.2`, …) map 1:1 to the underlying Cardlink SDK release. The Android Maven
artifact and the iOS XCFramework for a given version are produced from the same source
commit.

## License

Proprietary. © Scoop Software GmbH.
