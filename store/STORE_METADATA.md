# Browser Extension Store Listing & Hand-in Metadata

This document contains all metadata, descriptions, justifications, and store policy fields required when submitting Haspr to the **Chrome Web Store**, **Firefox Add-ons (AMO)**, and **Microsoft Edge Add-ons**.

---

## 1. General Extension Information

- **Extension Name**: Haspr - Password Manager
- **Short Name**: Haspr
- **Version**: {{VERSION}}
- **Primary Category**: Productivity
- **Secondary Category**: Security & Privacy
- **Support / Website URL**: https://doc.haspr.dev
- **Repository**: https://github.com/haspr-dev/haspr-browser-extension
- **Support Email / Issue Tracker**: https://github.com/haspr-dev/haspr-browser-extension/issues
- **Privacy Policy URL**: https://doc.haspr.dev
- **Gecko ID (Firefox AMO)**: `extension@haspr.dev`

---

## 2. Short Description

### Chrome Web Store (Max 132 characters)
```text
Cryptographic password manager, autofill, and quick access for Haspr and Passbolt-compatible instances.
```
*(103 characters)*

### Firefox Add-ons (AMO) Summary (Max 250 characters)
```text
Seamless cryptographic password management, quick access, and autofill for Haspr and Passbolt-compatible servers. Fully open source and end-to-end encrypted.
```
*(154 characters)*

---

## 3. Detailed Description (Plain text / Markdown)

```markdown
Haspr is an open-source, end-to-end encrypted password manager designed for individuals and teams who value data ownership and security.

The Haspr browser extension connects seamlessly to your self-hosted or cloud Haspr (or Passbolt-compatible) API instance, allowing you to access and autofill your credentials without sacrificing security.

Key Features:
• End-to-End Cryptography: All credentials and metadata are encrypted client-side using industry-standard OpenPGP keys before leaving your device.
• Intelligent Autofill: Automatically detects login forms, fills usernames and complex passwords, and handles multi-page authentication flows.
• Built-in OTP / 2FA: Generates and autofills time-based one-time passwords (TOTP) directly into login forms.
• Quick Access: Search and copy passwords, secret notes, and credentials instantly via keyboard shortcut (Alt+Shift+P) or extension popup.
• Native CLI & Agent Integration: Integrates with `go-haspr-cli` and background credential agents via native messaging.
• Granular Permissions: Share credentials with colleagues and groups with view, edit, or admin permissions.

Open Source & Independent:
Haspr is 100% free and open-source software (AGPL-3.0). It is independently maintained and compatible with the Passbolt API ecosystem.

Documentation & Source Code:
• Documentation: https://doc.haspr.dev
• GitHub: https://github.com/haspr-dev/haspr-browser-extension
```

---

## 4. Chrome Web Store: Single Purpose & Permission Justifications

Chrome Web Store requires a Single Purpose description and explicit justifications for every requested permission.

### Single Purpose Description
```text
Securely retrieve, decrypt, and autofill user credentials, passwords, and TOTP tokens stored in a Haspr or Passbolt-compatible server instance into web login forms.
```

### Permission Justifications
- **`activeTab`**:
  *Justification*: Required to inspect the active webpage's DOM to identify login input fields, detect URLs, and autofill credentials upon user interaction.
- **`storage` / `unlimitedStorage`**:
  *Justification*: Used to persist encrypted local session state, user settings, cached public keys, and offline encrypted credential metadata.
- **`tabs`**:
  *Justification*: Used to open new tabs for the initial setup ceremony, account recovery, password generation, and opening URLs associated with stored resources.
- **`clipboardWrite`**:
  *Justification*: Allows users to securely copy generated passwords, usernames, and 2FA tokens to the system clipboard from the quick access popup.
- **`alarms`**:
  *Justification*: Used to handle session timeout intervals, automatic locking after inactivity, and periodic background synchronization.
- **`cookies`**:
  *Justification*: Required to authenticate API requests with session cookies against the user's configured server endpoint.
- **`scripting`** (MV3):
  *Justification*: Used to inject in-page autofill badges and menu overlays into credential input fields.
- **`offscreen`** (MV3):
  *Justification*: Used to perform heavy cryptographic operations (OpenPGP key decryption and token generation) off the main service worker thread.

---

## 5. File Checklist for Hand-in / Upload

| Target Platform | File to Upload | Purpose |
| :--- | :--- | :--- |
| **Chrome Web Store** | `chrome-web-store-haspr-v{{VERSION}}.zip` | Upload as package in CWS Developer Dashboard |
| **Firefox Add-ons (AMO)** | `firefox-amo-haspr-v{{VERSION}}.zip` | Upload as new add-on version in AMO Developer Hub |
| **Firefox AMO Source Code** | `source-code-haspr-v{{VERSION}}.zip` | Required by Mozilla reviewer ("Does this version contain minified code? -> Yes") |
| **Firefox AMO Review Notes** | `BUILD_INSTRUCTIONS.txt` | Paste into "Information for Reviewer" text box |
| **Microsoft Edge Add-ons** | `edge-addons-haspr-v{{VERSION}}.zip` | Upload as package in Partner Center |
| **Store Icons** | `icons/icon-128.png`, `icons/icon-48.png`, `icons/icon-16.png` | Upload to Store Listing assets |
