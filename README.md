<p align="center">
  <img src="https://raw.githubusercontent.com/haspr-dev/.github/main/assets/haspr-logo.svg" alt="Haspr logo" width="160" height="160" />
</p>

<h1 align="center">haspr-browser-extension</h1>

<p align="center">
  <strong>Browser extension (Firefox, Chrome, Edge) for the Haspr ecosystem, compatible with Passbolt.</strong>
</p>

<p align="center">
  <a href="https://github.com/haspr-dev/haspr-browser-extension/blob/master/LICENSE.txt"><img src="https://img.shields.io/github/license/haspr-dev/haspr-browser-extension" alt="License" /></a>
  <a href="https://github.com/haspr-dev/haspr-api"><img src="https://img.shields.io/badge/API-haspr--api-256af2?style=flat-square" alt="API" /></a>
  <a href="https://github.com/haspr-dev/go-haspr-cli"><img src="https://img.shields.io/badge/CLI-go--haspr--cli-0bddec?style=flat-square&logo=go" alt="CLI" /></a>
</p>

---

## ⚡ Overview

The **Haspr browser extension** delivers seamless cryptographic password management, quick access, autofill, and native messaging integration with `go-haspr-cli` and background credential agents.

---

## ⚖️ Trademark Notice

*Passbolt is a registered trademark of Passbolt SA. **Haspr** is an independent community project and is not affiliated with, endorsed by, or sponsored by Passbolt SA.*

---

## 🛠️ Development & Building

### Prerequisites
- Node.js >= 22.14.0
- npm >= 10.9.2

```bash
git clone git@github.com:haspr-dev/haspr-browser-extension.git
cd haspr-browser-extension
npm ci
```

### Build Commands
```bash
# Build all web-accessible bundles
npm run build

# Run unit tests
npm test
```

### Loading the Unpacked Extension
- **Firefox**: Open `about:debugging#/runtime/this-firefox`, click "Load Temporary Add-on", and select `build/all/manifest.json`.
- **Chrome / Brave / Edge**: Open `chrome://extensions/`, enable "Developer mode", click "Load unpacked", and select `build/all`.
- **Safari / macOS**: See [Apple Safari & macOS Support](#-apple-safari--macos-support) below.

---

## 🍏 Apple Safari & macOS Support

The Haspr extension is currently **not** available in the Mac App Store / Safari Extensions gallery. Distributing Safari web extensions via the official Mac App Store requires an active Apple Developer Program subscription ($99 USD/year), which is not sustainable for an independent, community-driven open-source project.

However, macOS users can easily use Haspr in either of the following ways:

### 1. Using Chromium or Firefox on macOS (Recommended)
You can run Haspr on macOS out of the box using any supported browser:
- [Google Chrome](https://www.google.com/chrome/)
- [Mozilla Firefox](https://www.mozilla.org/firefox/)
- [Brave Browser](https://brave.com/)
- [Microsoft Edge](https://www.microsoft.com/edge)
- [Vivaldi](https://vivaldi.com/)

### 2. Self-building & Installing into Safari via Developer Mode
If you prefer Safari, you can build and load the extension locally using Apple's built-in developer tools:

1. **Build the extension**:
   ```bash
   npm run build
   ```
2. **Convert the extension for Safari**:
   ```bash
   xcrun safari-web-extension-converter build/all --project-location build/safari --app-name "Haspr"
   ```
3. **Open and build the project in Xcode**:
   Open the generated Xcode project in `build/safari/Haspr/Haspr.xcodeproj` and click **Run** (or `Cmd + R`).
4. **Enable Unsigned Extensions in Safari**:
   - Open Safari and go to **Settings > Advanced** (or **Preferences > Advanced**).
   - Check **Show features for web developers** (or **Show Develop menu in menu bar**).
   - In Safari's menu bar, click **Develop > Allow Unsigned Extensions** and enter your macOS password.
   - Go to **Settings > Extensions** and check the box next to **Haspr**.

---

## 📄 License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License (AGPL) as published by the Free Software Foundation version 3.

See [LICENSE.txt](LICENSE.txt) for details.
