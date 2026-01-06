#!/bin/bash
# release.sh
# Usage: ./release.sh "commit message" patch|minor|major

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 \"commit message\" patch|minor|major"
    exit 1
fi

COMMIT_MSG="$1"
BUMP_TYPE="$2"
VERSION_FILE="version.go"

# Read current version numbers
MAJOR=$(grep -E '^[[:space:]]*Major[[:space:]]*=' "$VERSION_FILE" | grep -oE '[0-9]+')
MINOR=$(grep -E '^[[:space:]]*Minor[[:space:]]*=' "$VERSION_FILE" | grep -oE '[0-9]+')
PATCH=$(grep -E '^[[:space:]]*Patch[[:space:]]*=' "$VERSION_FILE" | grep -oE '[0-9]+')

if [[ -z "$MAJOR" || -z "$MINOR" || -z "$PATCH" ]]; then
    echo "Failed to parse version from $VERSION_FILE"
    exit 1
fi

# Bump version
case "$BUMP_TYPE" in
    patch)
        PATCH=$((PATCH + 1))
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    *)
        echo "Invalid version type: $BUMP_TYPE"
        exit 1
        ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"

# Determine sed inline edit flags based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_INPLACE=(-i '')
else
    SED_INPLACE=(-i)
fi

# Update only the constants in version.go
sed "${SED_INPLACE[@]}" -E "s/^([[:space:]]*Major[[:space:]]*=[[:space:]]*)([0-9]+)/\1$MAJOR/" "$VERSION_FILE"
sed "${SED_INPLACE[@]}" -E "s/^([[:space:]]*Minor[[:space:]]*=[[:space:]]*)([0-9]+)/\1$MINOR/" "$VERSION_FILE"
sed "${SED_INPLACE[@]}" -E "s/^([[:space:]]*Patch[[:space:]]*=[[:space:]]*)([0-9]+)/\1$PATCH/" "$VERSION_FILE"

echo "Version updated to $NEW_VERSION"

# Git commit, tag, push
git add "$VERSION_FILE"
git commit -am "$COMMIT_MSG"
git tag "v$NEW_VERSION"
git push
git push origin "v$NEW_VERSION"

echo "Released $NEW_VERSION successfully!"
