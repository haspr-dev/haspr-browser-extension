#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
cd "${ROOT_DIR}"

VERSION=$(node -p "require('./package.json').version")
OUTPUT_DIR="dist/store-submission"

echo "=== Preparing Store Submission Files for Haspr v${VERSION} ==="
mkdir -p "${OUTPUT_DIR}/icons"

# Resolve package paths (check dist/chromium-mv3 or dist/release)
CHROME_ZIP=""
FIREFOX_ZIP=""
SAFARI_ZIP=""

if [ -f "dist/chromium-mv3/haspr-${VERSION}-chromium-mv3.zip" ]; then
  CHROME_ZIP="dist/chromium-mv3/haspr-${VERSION}-chromium-mv3.zip"
elif [ -f "dist/release/haspr-${VERSION}-chromium-mv3.zip" ]; then
  CHROME_ZIP="dist/release/haspr-${VERSION}-chromium-mv3.zip"
fi

if [ -f "dist/firefox/haspr-${VERSION}-firefox.zip" ]; then
  FIREFOX_ZIP="dist/firefox/haspr-${VERSION}-firefox.zip"
elif [ -f "dist/release/haspr-${VERSION}-firefox.zip" ]; then
  FIREFOX_ZIP="dist/release/haspr-${VERSION}-firefox.zip"
fi

if [ -f "dist/safari/haspr-${VERSION}-safari.zip" ]; then
  SAFARI_ZIP="dist/safari/haspr-${VERSION}-safari.zip"
elif [ -f "dist/release/haspr-${VERSION}-safari.zip" ]; then
  SAFARI_ZIP="dist/release/haspr-${VERSION}-safari.zip"
fi

if [ -z "${CHROME_ZIP}" ] || [ -z "${FIREFOX_ZIP}" ]; then
  echo "Error: Required build artifacts for v${VERSION} not found."
  echo "Please build the extension before packaging store submission files."
  exit 1
fi

# 1. Package for Chrome Web Store (Manifest V3)
echo "Packaging for Chrome Web Store..."
cp "${CHROME_ZIP}" "${OUTPUT_DIR}/chrome-web-store-haspr-v${VERSION}.zip"

# 2. Package for Firefox Add-ons (AMO) (Manifest V2)
echo "Packaging for Firefox Add-ons (AMO)..."
cp "${FIREFOX_ZIP}" "${OUTPUT_DIR}/firefox-amo-haspr-v${VERSION}.zip"

# 3. Package for Microsoft Edge Add-ons (Manifest V3)
echo "Packaging for Microsoft Edge Add-ons..."
cp "${CHROME_ZIP}" "${OUTPUT_DIR}/edge-addons-haspr-v${VERSION}.zip"

# 4. Package for Safari
if [ -n "${SAFARI_ZIP}" ]; then
  echo "Packaging for Safari..."
  cp "${SAFARI_ZIP}" "${OUTPUT_DIR}/safari-haspr-v${VERSION}.zip"
fi

# 5. Generate reproducible source archive for AMO reviewers
echo "Generating reproducible source code archive..."
git archive --format=zip --prefix="haspr-browser-extension-${VERSION}/" HEAD -o "${OUTPUT_DIR}/source-code-haspr-v${VERSION}.zip"

# 6. Extract store icons
echo "Extracting store icons..."
unzip -j -o "${CHROME_ZIP}" \
  "webAccessibleResources/img/icons/icon-128.png" \
  "webAccessibleResources/img/icons/icon-48.png" \
  "webAccessibleResources/img/icons/icon-16.png" \
  "webAccessibleResources/img/logo/logo.svg" \
  -d "${OUTPUT_DIR}/icons/" 2>/dev/null || true

# 7. Copy and format store documentation & instructions
if [ -d "store" ]; then
  echo "Copying store metadata and build instructions..."
  sed "s/{{VERSION}}/${VERSION}/g; s/5\.18\.[0-9]*/${VERSION}/g" store/BUILD_INSTRUCTIONS.txt > "${OUTPUT_DIR}/BUILD_INSTRUCTIONS.txt"
  sed "s/{{VERSION}}/${VERSION}/g; s/5\.18\.[0-9]*/${VERSION}/g" store/STORE_METADATA.md > "${OUTPUT_DIR}/STORE_METADATA.md"
fi

# 8. Create an all-in-one zip archive
echo "Creating all-in-one store submission archive..."
(cd "${OUTPUT_DIR}" && zip -r -q "../../dist/haspr-store-submission-v${VERSION}.zip" .)

echo "=== Store Submission Bundle Complete ==="
echo "Files ready in ${OUTPUT_DIR}/ and dist/haspr-store-submission-v${VERSION}.zip"
ls -lh "${OUTPUT_DIR}"
