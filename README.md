# Scoop SDK — public packages

> [!WARNING]
> **Legacy public distribution route — existing consumers only.** Do **not** use this
> repository for new Evaluation or Pilot integrations. New Evaluation/Pilot consumers
> must use SCOOP's authenticated Gitea registries at
> `https://ti-gitea.scoop-gmbh.de` and the exact package identities and versions in
> their SCOOP delivery manifest. Existing consumers may retain their current pins
> until a migration has been assigned and verified.

Public, **credential-free** binary distribution of the Scoop mobile SDKs for German
eHealth (eGK / NFC / CardLink / PoPP / eRezept), for both **iOS (Swift Package Manager)**
and **Android (Maven)**. The information below is retained as a historical reference
for existing consumers of this public channel.

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
> 📖 **[Historical public-channel guide →](getting-started.md)**

## Historical installation reference for existing consumers

### iOS — Swift Package Manager

For an existing consumer already pinned to the public GitHub channel, the historical
`4.0.0` reference is:

```swift
.package(url: "https://github.com/scoop-software/cardlink-packages.git", exact: "4.0.0")
```

This is not an installation path for new Evaluation/Pilot work. Existing integrations
may continue using their assigned pins while their migration is assigned and verified.
For new Evaluation/Pilot integrations, use the authenticated Gitea registries at
`https://ti-gitea.scoop-gmbh.de` and follow the exact identities and versions in the
SCOOP delivery manifest.

In an existing Xcode integration, the package was added via **File → Add Package
Dependencies…** with the URL above. Existing targets may import the products they need:

```swift
import ScoopCardlink   // CardLink flow (bundles the NFC core)
import ScoopNfc        // NFC core (eGK / PACE / Secure Messaging)
import ScoopNfcUI      // SwiftUI components: CAN scanner, CAN input, eGK card view
import ScoopPopp       // reviewed PoPP module
```

### Android — Gradle

The public GitHub-Pages Maven tree is a historical, credential-free channel for
existing consumers only. It still serves only the retired `shared-android` line
(≤ 2.2.0) and is not updated for 3.x/4.x. New Evaluation/Pilot integrations must use
the authenticated Gitea registries at `https://ti-gitea.scoop-gmbh.de` and the exact
package identities and versions in their SCOOP delivery manifest.

## Build settings (Xcode 26)

Since the 3.x/4.x releases the XCFrameworks ship **textual `.swiftinterface` files with
Library Evolution** and a universal simulator slice (`arm64` + `x86_64`). No special
build settings are required; consumers are not tied to the exact Swift compiler patch
version. Minimum toolchain: **Xcode 26 / Swift 6.2**.

## Historical public distribution

| Channel | Where | Served by |
| ------- | ----- | --------- |
| iOS XCFrameworks | `Package.swift` (this branch) + ZIPs on **Releases** | Swift Package Manager |
| Android AARs | `maven/` tree on the **`gh-pages`** branch (POM-only, no Gradle module metadata) | GitHub Pages, anonymous |

No GitHub token or credentials are required for this historical public channel.

## Documentation

- **[getting-started.md](getting-started.md)** — historical public-channel integration and demo-build reference for existing consumers.
- **[cardlink-sdk-demos/docs/API.md](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md)** — full written API reference (every flow, with snippets). iOS also has inline Quick Help in Xcode (⌥-click any symbol).
- **[scoop-software/cardlink-sdk-demos](https://github.com/scoop-software/cardlink-sdk-demos)** — runnable native demo apps (`android/`, `ios/`).

> NFC features require a **physical device** with NFC, the NFC entitlement, and the
> ISO 7816 / reader-session keys in your target's `Info.plist`.

## License

Proprietary. © SCOOP Software GmbH.
