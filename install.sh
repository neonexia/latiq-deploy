#!/bin/sh
# Install the Latiq admin CLI (a small, client-only `latiq` — no server/DuckDB).
#   curl -fsSL https://raw.githubusercontent.com/neonexia/latiq-deploy/main/install.sh | sh
# Then:  export LATIQ_SERVER=http://your-control-plane:51400 && latiq stats
#
# Override the install dir with LATIQ_BIN_DIR (default ~/.local/bin).
set -eu

repo="neonexia/latiq-deploy"
tag="cli-latest"

os=$(uname -s)
arch=$(uname -m)
case "$os" in
  Darwin) os=darwin ;;
  Linux)  os=linux ;;
  *) echo "latiq: unsupported OS '$os' (macOS/Linux only)"; exit 1 ;;
esac
case "$arch" in
  arm64|aarch64) arch=arm64 ;;
  x86_64|amd64)  arch=x86_64 ;;
  *) echo "latiq: unsupported arch '$arch'"; exit 1 ;;
esac

asset="latiq-${os}-${arch}"
url="https://github.com/${repo}/releases/download/${tag}/${asset}"
dir="${LATIQ_BIN_DIR:-$HOME/.local/bin}"

echo "latiq: downloading ${asset}"
mkdir -p "$dir"
curl -fSL "$url" -o "$dir/latiq"
chmod +x "$dir/latiq"
echo "latiq: installed to $dir/latiq"

case ":$PATH:" in
  *":$dir:"*) : ;;
  *) echo "latiq: add $dir to your PATH, e.g.  export PATH=\"$dir:\$PATH\"" ;;
esac
echo "latiq: try  export LATIQ_SERVER=http://your-control-plane:51400 && latiq stats"
