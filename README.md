# Scoop SDK — public packages

Public, **credential-free** binary distribution of the Scoop mobile SDKs for German
eHealth (eGK / NFC / CardLink / PoPP / eRezept), for both **iOS (Swift Package Manager)**
and **Android (Maven)**:

| SDK | iOS SPM product(s) | Android Maven coordinate | Version |
| --- | --- | --- | --- |
| **Cardlink** | `ScoopCardlink` | `de.scoopsoftware.cardlink:cardlink-android` | 4.0.0 |
| **NFC** | `ScoopNfc`, `ScoopNfcUI` | `de.scoopsoftware.nfc:nfc-android` | 3.0.0 |
| **PoPP Module** | `ScoopPopp` | `de.scoopsoftware.popp:popp-module-android` | 0.21.0 |

> The PoPP convenience SDK (`ScoopPoppSDK`, `de.scoopsoftware.popp.sdk:popp-sdk-android` 2.0.0)
> is distributed via the private Gitea registry only, not through this public repo.

This repo hosts only the manifests and compiled binaries; the SDK **sources stay private**
in their respective repos. `ScoopCardlink` statically bundles the NFC core (PoPP is a
separate product since the PoPP split), so a CardLink integration needs `ScoopCardlink`
plus `ScoopNfcUI` for the SDK-owned CAN scanner and card UI.

> **iOS 15+ / Xcode 26+** · Android `minSdk 26` / JDK 17
>
> 📖 **[Vendor getting-started guide →](getting-started.md)**

## Install

### iOS — Swift Package Manager

```swift
.package(url: "https://github.com/scoop-software/cardlink-packages.git", exact: "4.0.0")
```

…or in Xcode: **File → Add Package Dependencies…** and paste the URL above. Then add the
products you need to your target and import them:

```swift
import ScoopCardlink   // CardLink flow (bundles the NFC core)
import ScoopNfc        // NFC core (eGK / PACE / Secure Messaging)
import ScoopNfcUI      // SwiftUI components: CAN scanner, CAN input, eGK card view
import ScoopPopp       // reviewed PoPP module
```

### Android — Gradle

Current Android artifacts (`cardlink-android` 4.0.0, `nfc-android` 3.0.0,
`popp-module-android` 0.21.0) are distributed via the private **Gitea Maven registry**
(credentials required) — see the vendor guide for the repository blocks. The legacy
credential-free GitHub-Pages Maven tree still serves only the retired
`shared-android` line (≤ 2.2.0) and is not updated for 3.x/4.x; whether the public
Android channel continues is a pending distribution decision.

## Build settings (Xcode 26)

Since the 3.x/4.x releases the XCFrameworks ship **textual `.swiftinterface` files with
Library Evolution** and a universal simulator slice (`arm64` + `x86_64`). No special
build settings are required; consumers are not tied to the exact Swift compiler patch
version. Minimum toolchain: **Xcode 26 / Swift 6.2**.

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

Proprietary. © SCOOP Software GmbH.
