#!/usr/bin/env sh
#
# Gradle 8.5 Wrapper Script for Linux / Ubuntu CI (Smouha Stock)
# Automatically uses Gradle 8.5 from GRADLE_HOME, PATH, or downloads gradle-8.5-bin.zip into ~/.gradle/wrapper/dists
#
set -e

GRADLE_VERSION="8.5"
GRADLE_DIST_DIR="${HOME}/.gradle/wrapper/dists/gradle-${GRADLE_VERSION}-bin"
GRADLE_BIN="${GRADLE_DIST_DIR}/gradle-${GRADLE_VERSION}/bin/gradle"

if [ ! -x "$GRADLE_BIN" ]; then
  echo "Bootstrapping Gradle ${GRADLE_VERSION} distribution..."
  mkdir -p "$GRADLE_DIST_DIR"
  TMP_ZIP="${GRADLE_DIST_DIR}/gradle-${GRADLE_VERSION}-bin.zip"
  curl -fsSL --retry 5 --retry-delay 5 --retry-all-errors "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o "$TMP_ZIP"
  unzip -q -o "$TMP_ZIP" -d "$GRADLE_DIST_DIR"
  rm -f "$TMP_ZIP"
  chmod +x "$GRADLE_BIN"
fi

exec "$GRADLE_BIN" "$@"
