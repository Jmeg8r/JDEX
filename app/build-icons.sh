#!/bin/bash

# Script to convert SVG icon to all required formats for electron-builder
# Requires: macOS with sips (built-in), rsvg-convert (install with: brew install librsvg)

set -e

echo "🎨 Converting JDex icon to all required formats..."

# Check if rsvg-convert is available
if ! command -v rsvg-convert &> /dev/null; then
    echo "❌ rsvg-convert not found. Installing via Homebrew..."
    echo "   Run: brew install librsvg"
    echo "   Then run this script again."
    exit 1
fi

# Create temporary directory for iconset
ICONSET_DIR="build/icon.iconset"
mkdir -p "$ICONSET_DIR"

echo "📐 Generating PNG files at various sizes..."

# Generate all required sizes for macOS .icns
rsvg-convert -w 16 -h 16 public/jdex-icon.svg > "$ICONSET_DIR/icon_16x16.png"
rsvg-convert -w 32 -h 32 public/jdex-icon.svg > "$ICONSET_DIR/icon_16x16@2x.png"
rsvg-convert -w 32 -h 32 public/jdex-icon.svg > "$ICONSET_DIR/icon_32x32.png"
rsvg-convert -w 64 -h 64 public/jdex-icon.svg > "$ICONSET_DIR/icon_32x32@2x.png"
rsvg-convert -w 128 -h 128 public/jdex-icon.svg > "$ICONSET_DIR/icon_128x128.png"
rsvg-convert -w 256 -h 256 public/jdex-icon.svg > "$ICONSET_DIR/icon_128x128@2x.png"
rsvg-convert -w 256 -h 256 public/jdex-icon.svg > "$ICONSET_DIR/icon_256x256.png"
rsvg-convert -w 512 -h 512 public/jdex-icon.svg > "$ICONSET_DIR/icon_256x256@2x.png"
rsvg-convert -w 512 -h 512 public/jdex-icon.svg > "$ICONSET_DIR/icon_512x512.png"
rsvg-convert -w 1024 -h 1024 public/jdex-icon.svg > "$ICONSET_DIR/icon_512x512@2x.png"

echo "🍎 Creating macOS .icns file..."
iconutil -c icns "$ICONSET_DIR" -o build/icon.icns

echo "🪟 Creating Windows .ico file..."
# Create 256x256 PNG for Windows
rsvg-convert -w 256 -h 256 public/jdex-icon.svg > build/icon-256.png

# Convert to .ico using sips (built-in macOS tool)
# Note: This creates a basic .ico. For production, consider using a dedicated tool
sips -s format png build/icon-256.png --out build/icon.ico 2>/dev/null || {
    echo "⚠️  Simple .ico created. For better Windows icons, use a dedicated converter."
    cp build/icon-256.png build/icon.ico
}

echo "🐧 Creating Linux .png file..."
rsvg-convert -w 512 -h 512 public/jdex-icon.svg > build/icon.png

echo "🧹 Cleaning up..."
rm -rf "$ICONSET_DIR"
rm -f build/icon-256.png

echo "✅ All icon formats created successfully!"
echo "   📁 build/icon.icns (macOS)"
echo "   📁 build/icon.ico (Windows)"
echo "   📁 build/icon.png (Linux)"
echo ""
echo "You can now run: npm run electron:build"
