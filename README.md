# Cardlink SDK — public packages

Public, **credential-free** binary distribution of the **ScoopCardlink** SDK — NFC-based
German health-card (eGK) authentication and eHealth flows (CardLink, PoPP check-in,
eRezept) — for both **iOS (Swift Package Manager)** and **Android (Maven)**.

This repo hosts only the manifests and compiled binaries; the SDK **source stays private**
in [`scoop-software/cardlink-sdk`](https://github.com/scoop-software/cardlink-sdk).

> **Current release: 2.2.0** · iOS 14+ / **Xcode 26+** · Android `minSdk 26` / JDK 17
>
> 📖 **[Vendor getting-started guide →](getting-started.md)**

## Install

### iOS — Swift Package Manager

```swift
.package(url: "https://github.com/scoop-software/cardlink-packages.git", from: "2.2.0")
```

…or in Xcode: **File → Add Package Dependencies…** and paste the URL above. Then
`import ScoopCardlink`.

### Android — Gradle (no token required)

```kotlin
repositories {
    maven { url = uri("https://scoop-software.github.io/cardlink-packages/maven") }
}
dependencies {
    implementation("de.scoopsoftware.cardlink:shared-android:2.2.0")
}
```

## Required build settings (Xcode 26)

The framework ships a binary `.swiftmodule` (no library evolution). On the target that
imports `ScoopCardlink`, set:

| Setting | Value | Why |
| ------- | ----- | --- |
| `SWIFT_ENABLE_EXPLICIT_MODULES` | `NO` | Xcode 26's explicit-module build otherwise rebuilds the framework interface and drops the SDK's Swift types (`cannot find type 'ErezeptType'…`). |
| `EXCLUDED_ARCHS[sdk=iphonesimulator*]` | `x86_64` | The simulator slice is arm64 only (Apple Silicon). |

The binary is tied to its build's Swift compiler — **use Xcode 26.x** (it is rebuilt and
re-released per Xcode major version).

## How it's distributed

| Channel | Where | Served by |
| ------- | ----- | --------- |
| iOS XCFramework | `Package.swift` (this branch) + ZIP on **Releases** | Swift Package Manager |
| Android AAR | `maven/` tree on the **`gh-pages`** branch | GitHub Pages, anonymous |

No GitHub token or credentials are required to consume either platform.

## Documentation

- **[getting-started.md](getting-started.md)** — integration + demo build guide for vendors.
- **[cardlink-sdk-demos/docs/API.md](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md)** — full written API reference (every flow, with snippets). iOS also has inline Quick Help in Xcode (⌥-click any symbol).
- **[scoop-software/cardlink-sdk-demos](https://github.com/scoop-software/cardlink-sdk-demos)** — runnable native demo apps (`android/`, `ios/`).

> NFC features require a **physical device** with NFC, the NFC entitlement, and the
> ISO 7816 / reader-session keys in your target's `Info.plist`.

## Versioning

Tags (`v2.2.0`, …) map 1:1 to the underlying Cardlink SDK release. The Android Maven
artifact and the iOS XCFramework for a given version are produced from the same source
commit.

## License

Proprietary. © Scoop Software GmbH.
