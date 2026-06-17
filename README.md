# Scoop SDK — public packages

Public, **credential-free** binary distribution of the Scoop mobile SDKs for German
eHealth (eGK / NFC / CardLink / PoPP / eRezept), for both **iOS (Swift Package Manager)**
and **Android (Maven)**:

| SDK | iOS SPM product(s) | Android Maven coordinate | Version |
| --- | --- | --- | --- |
| **Cardlink** | `ScoopCardlink` | `de.scoopsoftware.cardlink:shared-android` | 2.2.0 |
| **NFC** | `ScoopNfc`, `ScoopNfcUI` | `de.scoopsoftware.nfc:shared-android` | 2.0.1 |
| **PoPP** | `ScoopPopp` | `de.scoopsoftware.popp:shared-android` | 0.18.0 |

This repo hosts only the manifests and compiled binaries; the SDK **sources stay private**
in their respective repos. `ScoopCardlink` statically bundles NFC + PoPP, so most CardLink
integrations only need `ScoopCardlink`.

> **iOS 14+ / Xcode 26+** · Android `minSdk 26` / JDK 17
>
> 📖 **[Vendor getting-started guide →](getting-started.md)**

## Install

### iOS — Swift Package Manager

```swift
.package(url: "https://github.com/scoop-software/cardlink-packages.git", from: "2.2.0")
```

…or in Xcode: **File → Add Package Dependencies…** and paste the URL above. Then add the
products you need to your target and import them:

```swift
import ScoopCardlink   // CardLink flow (bundles NFC + PoPP)
import ScoopNfc        // NFC core (eGK / PACE / Secure Messaging)
import ScoopNfcUI      // optional SwiftUI components for NFC
import ScoopPopp        // PoPP module
```

### Android — Gradle (no token required)

```kotlin
repositories {
    maven { url = uri("https://scoop-software.github.io/cardlink-packages/maven") }
}
dependencies {
    implementation("de.scoopsoftware.cardlink:shared-android:2.2.0") // pulls nfc + popp transitively
    // or depend on the individual SDKs directly:
    // implementation("de.scoopsoftware.nfc:shared-android:2.0.1")
    // implementation("de.scoopsoftware.popp:shared-android:0.18.0")
}
```

## Required build settings (Xcode 26)

The frameworks ship a binary `.swiftmodule` (no library evolution). On the target that
imports any Scoop product, set:

| Setting | Value | Why |
| ------- | ----- | --- |
| `SWIFT_ENABLE_EXPLICIT_MODULES` | `NO` | Xcode 26's explicit-module build otherwise rebuilds the framework interface and drops the SDK's Swift types (`cannot find type 'ErezeptType'…`). |
| `EXCLUDED_ARCHS[sdk=iphonesimulator*]` | `x86_64` | The simulator slices are arm64 only (Apple Silicon). |

The binaries are tied to their build's Swift compiler — **use Xcode 26.x** (rebuilt and
re-released per Xcode major version).

## How it's distributed

| Channel | Where | Served by |
| ------- | ----- | --------- |
| iOS XCFrameworks | `Package.swift` (this branch) + ZIPs on **Releases** | Swift Package Manager |
| Android AARs | `maven/` tree on the **`gh-pages`** branch (POM-only, no Gradle module metadata) | GitHub Pages, anonymous |

No GitHub token or credentials are required for either platform.

## Documentation

- **[getting-started.md](getting-started.md)** — integration + demo build guide for vendors.
- **[cardlink-sdk-demos/docs/API.md](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md)** — full written API reference (every flow, with snippets). iOS also has inline Quick Help in Xcode (⌥-click any symbol).
- **[scoop-software/cardlink-sdk-demos](https://github.com/scoop-software/cardlink-sdk-demos)** — runnable native demo apps (`android/`, `ios/`).

> NFC features require a **physical device** with NFC, the NFC entitlement, and the
> ISO 7816 / reader-session keys in your target's `Info.plist`.

## License

Proprietary. © Scoop Software GmbH.
