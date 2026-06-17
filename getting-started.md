# Getting Started (for Vendors)

This guide walks you through **integrating the Cardlink SDK into your own app** and
**building & running the bundled demo**. It covers both native distribution targets:
Android and iOS.

For a feature overview and install reference, see the [package README](https://github.com/scoop-software/cardlink-packages#readme).

---

## 1. Prerequisites

| Tool | Version | Needed for |
| ---- | ------- | ---------- |
| JDK | 17+ | Android / SDK build |
| Android SDK | API 26+ (compileSdk 34/35) | Android |
| Xcode | 26+ | iOS (the SPM XCFramework ships a binary `.swiftmodule` — see §2b) |
| `gh` CLI | latest | Maintainers publishing releases |

The repo pins **Gradle 8.12.1** (via the wrapper — use `./gradlew`), **Kotlin 2.3.10**,
and **AGP 8.7.2**. No `asdf`/SDKMAN config is used.

### Distribution

Both SDK artifacts are published to a single **public** repo,
[`scoop-software/cardlink-packages`](https://github.com/scoop-software/cardlink-packages):

- **iOS** via Swift Package Manager (the repo's `Package.swift` + an XCFramework attached to GitHub Releases).
- **Android** via a static Maven repository served on **GitHub Pages** at `https://scoop-software.github.io/cardlink-packages/maven`.

**No GitHub token or credentials are required** to consume either platform. Only the
compiled binaries are public — the SDK **source stays private** in `cardlink-sdk`.

---

## 2. Integrating the SDK

Current package versions:

| SDK | iOS (SPM) product | Android (Maven) coordinate | Version |
| --- | --- | --- | --- |
| Cardlink | `ScoopCardlink` | `de.scoopsoftware.cardlink:shared-android` | 2.2.0 |
| NFC | `ScoopNfc`, `ScoopNfcUI` | `de.scoopsoftware.nfc:shared-android` | 2.0.1 |
| PoPP | `ScoopPopp` | `de.scoopsoftware.popp:shared-android` | 0.18.0 |

All three ship from the same `cardlink-packages` repo (SPM products + one Maven repo).
`ScoopCardlink` bundles NFC + PoPP, so a CardLink integration usually needs only it; the
snippets below use Cardlink. For NFC- or PoPP-only apps, swap in the matching product /
coordinate above.

**The high-level flows** — full API and Kotlin/Swift snippets are in the
[API Reference](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md):

| Flow | Entry point | What it does |
| ---- | ----------- | ------------ |
| CardLink | [`CardlinkFlow`](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md#cardlink-flow) | OAuth → SMS → NFC (eGK) → prescription retrieval |
| PoPP check-in | [`PoppFlow`](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md#popp-check-in-proof-of-patient-presence) | LEI selection → consent → eGK / GesundheitsID auth → PoPP token — see the [flow diagram](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/popp-flow.md) |
| eRezept | [upload / delete](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md#erezept-upload--delete) | upload a test prescription, then delete it |
| Card reading | [`CardlinkNfcSession`](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md#card-reading--nfc-primitives) | read eGK files directly (no server flow) |

### 2a. Native Android (Gradle)

Add the public Maven repository and the dependency — **no credentials needed**:

```kotlin
// settings.gradle.kts (dependencyResolutionManagement) or module build.gradle.kts
repositories {
    maven { url = uri("https://scoop-software.github.io/cardlink-packages/maven") }
}

dependencies {
    implementation("de.scoopsoftware.cardlink:shared-android:2.2.0")
}
```

**Requirements:** `minSdk 26`, Java 17. Only the **release** variant is published.

> **API docs:** the artifact ships no sources/javadoc jar — use the written
> **[API Reference](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md)**
> (every flow, with Kotlin snippets) as your reference.

### 2b. Native iOS (Swift Package Manager)

In Xcode: **File → Add Package Dependencies…** and enter
`https://github.com/scoop-software/cardlink-packages.git`, or add it to `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/scoop-software/cardlink-packages.git", from: "2.2.0")
]
```

> SPM is served from the public `cardlink-packages` repo (which hosts only
> `Package.swift` + the XCFramework release ZIP); the SDK source stays private.

Then import it:

```swift
import ScoopCardlink
```

The package ships as a binary **`ScoopCardlink.xcframework`** (downloaded from the
GitHub Release ZIP). **Minimum deployment target: iOS 14.0.** The simulator slice is
Apple Silicon only (no x86_64).

> **⚠️ Xcode 26 — required build setting.** Set **`SWIFT_ENABLE_EXPLICIT_MODULES = NO`**
> on the target that imports `ScoopCardlink` (Build Settings → search *“Explicitly
> Built Modules”* → **No**, or add `SWIFT_ENABLE_EXPLICIT_MODULES = NO` to your
> `.xcconfig`). The framework ships a binary `.swiftmodule`; Xcode 26's explicit-module
> build would otherwise rebuild the framework's interface and silently drop the
> SKIE-generated Swift types — e.g. `cannot find type 'ErezeptType' in scope`. On Apple
> Silicon also set **`EXCLUDED_ARCHS[sdk=iphonesimulator*] = x86_64`** (the framework
> has no x86_64 simulator slice). Because the framework carries no library evolution,
> the binary is tied to its build's Swift compiler — rebuild/republish per Xcode major.
>
> **NFC features** require a **physical device** with NFC (iPhone 7 or later) and the
> appropriate NFC entitlements + `Info.plist` ISO 7816 / reader-session keys in your
> target.

---

## 3. Building & running the demo

The native **Android & iOS** demos live in their own repo,
[`scoop-software/cardlink-sdk-demos`](https://github.com/scoop-software/cardlink-sdk-demos)
(`android/` and `ios/`), consuming the **published** SDK artifacts.

> **NFC flows require a physical device.** Default targets used by this project:
> iOS — iPhone 13 Pro (`00008110-000111CA11A0401E`); Android — Pixel 8.

### 3a. Android demo

```bash
# Resolves the SDK from the public Maven repo (no credentials needed, §2a)
cd cardlink-sdk-demos/android && ./gradlew :app:assembleDebug
#   (build against local SDK source instead: ./gradlew assembleDevDebug)
```

### 3b. iOS demo

Open `cardlink-sdk-demos/ios/CardlinkDemo.xcodeproj` in **Xcode 26+** and run — SPM
resolves `cardlink-packages` / `nfc-sdk-spm`, and the project already carries the
required `SWIFT_ENABLE_EXPLICIT_MODULES = NO` setting (see §2b). See that repo's README
for device deployment and dev-mode details.

Maintainers building the XCFramework from this repo (e.g. before a release):

```bash
# Fast — device only (~1 min)
./gradlew :packages:sdk:shared:buildXCFrameworkDevice

# Full — device + simulator (~5 min), for distribution
./gradlew :packages:sdk:shared:buildXCFramework
```

---

## 4. Where to go next

All links are public — no access to the private SDK source is needed:

- **[API Reference](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/API.md)** — canonical consumer API for every flow (CardLink, PoPP, eRezept, card reading, metrics), with Kotlin/Swift snippets. iOS also has inline Quick Help in Xcode.
- **[PoPP flow diagram](https://github.com/scoop-software/cardlink-sdk-demos/blob/main/docs/popp-flow.md)** — the PoPP check-in state machine (states, transitions, design notes).
- **[Demo apps](https://github.com/scoop-software/cardlink-sdk-demos)** — runnable native Android + iOS integrations of every flow.
- **[Package README](https://github.com/scoop-software/cardlink-packages#readme)** — install reference + required Xcode 26 build settings.
