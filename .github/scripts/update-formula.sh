#!/usr/bin/env bash
set -euo pipefail

: "${VERSION:?VERSION must be set (e.g. v1.2.3)}"
: "${ARM64_SHA:?ARM64_SHA must be set (SHA256 of tagboard-tui-darwin-arm64)}"
: "${AMD64_SHA:?AMD64_SHA must be set (SHA256 of tagboard-tui-darwin-amd64)}"

FORMULA="Formula/tagboard-tui.rb"

# Strip leading 'v' from the version tag (e.g. v1.2.3 → 1.2.3)
VERSION_CLEAN="${VERSION#v}"

python3 - "$FORMULA" "$VERSION_CLEAN" "$ARM64_SHA" "$AMD64_SHA" <<'PYEOF'
import re, sys

formula_path = sys.argv[1]
version_clean = sys.argv[2]
arm64_sha     = sys.argv[3]
amd64_sha     = sys.argv[4]

with open(formula_path) as f:
    content = f.read()

# Update version field
content = re.sub(
    r'version "[^"]+"',
    f'version "{version_clean}"',
    content,
)

# Update sha256 in the on_arm block
content = re.sub(
    r'(on_arm do\s+url "[^"]+"\s+sha256 ")[^"]+"',
    lambda m: m.group(1) + arm64_sha + '"',
    content,
    flags=re.DOTALL,
)

# Update sha256 in the on_intel block
content = re.sub(
    r'(on_intel do\s+url "[^"]+"\s+sha256 ")[^"]+"',
    lambda m: m.group(1) + amd64_sha + '"',
    content,
    flags=re.DOTALL,
)

with open(formula_path, "w") as f:
    f.write(content)
PYEOF

echo "Updated $FORMULA to version $VERSION_CLEAN"
