#!/usr/bin/env bash
# macOS sensible defaults — los 6 favoritos
# Idempotente: corre las veces que quieras.
# Reversible: cada setting se puede revertir borrando la clave del plist.

set -e

# ─── 1. Sin smart quotes / dashes / capitalization / autocorrect ──────────────
# Evita que macOS reemplace " por “ y ” (rompe copy/paste de código).
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled    -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled     -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled   -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled       -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled   -bool false

# ─── 2. Mostrar extensiones de archivo + archivos ocultos ─────────────────────
defaults write NSGlobalDomain AppleShowAllExtensions   -bool true
defaults write com.apple.finder AppleShowAllFiles      -bool true
# Sin warning al cambiar extensión
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ─── 3. Screenshots a JPG en ~/Downloads ──────────────────────────────────────
mkdir -p "$HOME/Downloads"
defaults write com.apple.screencapture location       -string "$HOME/Downloads"
defaults write com.apple.screencapture type           -string "jpg"
defaults write com.apple.screencapture disable-shadow -bool   true
# Sin el prefijo "Screenshot" en el nombre — usa solo timestamp
defaults write com.apple.screencapture name           -string ""

# ─── 4. Key repeat rápido + tap to click ──────────────────────────────────────
# KeyRepeat: menor = más rápido. Mínimo seguro = 2 (1 puede ser inusable)
defaults write NSGlobalDomain KeyRepeat        -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Tap to click en trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad                  Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior              -int 1

# ─── 5. Finder: search en carpeta actual (no en todo el Mac) ──────────────────
# SCcf = SearchCurrentFolder, SCev = SearchEverywhere
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# ─── 6. Dock: no mostrar apps recientes ───────────────────────────────────────
defaults write com.apple.dock show-recents -bool false

# ─── Restart services para aplicar (no necesita logout) ────────────────────────
killall Finder       2>/dev/null || true
killall Dock         2>/dev/null || true
killall SystemUIServer 2>/dev/null || true
