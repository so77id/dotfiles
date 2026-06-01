<div align="center">

# ⚡ dotfiles

**Modern macOS dotfiles for Apple Silicon — opinionated, idempotent, beautiful.**

One `make install` away from a fully configured dev machine.

[![macOS](https://img.shields.io/badge/macOS-26+-000000?style=flat-square&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-arm64-555555?style=flat-square&logo=apple&logoColor=white)](https://en.wikipedia.org/wiki/Apple_silicon)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051?style=flat-square)](https://www.zsh.org/)
[![Homebrew](https://img.shields.io/badge/Homebrew-FBB040?style=flat-square&logo=homebrew&logoColor=white)](https://brew.sh)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)

</div>

---

## ✨ Features

- 🍺 **Bootstraps Homebrew + 26 CLI tools + 15 GUI apps** with a single command
- 🎨 **iTerm2** color preset and Nerd Font configured automatically as default profile
- 💻 **Zsh** with Oh My Zsh, [powerlevel10k](https://github.com/romkatv/powerlevel10k), autosuggestions and syntax highlighting
- 🪟 **System defaults** applied: language, keyboard layouts, timezone, sensible Finder/Dock/screenshot tweaks
- 🌐 **Brave** set as default browser (where macOS permits)
- 🎯 **Idempotent** — re-run `make install` anytime, skips what's already installed
- 💄 **Beautiful output** with [gum](https://github.com/charmbracelet/gum) spinners and color-coded results
- 🔁 **Resilient** — a single package failure doesn't abort the whole install

---

## 🚀 Quick Install

```bash
# 1. Clone
git clone https://github.com/so77id/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Install everything
make install
```

That's it. The Makefile detects what's missing (Xcode CLT, Homebrew, OMZ, plugins, packages, configs) and installs only what's needed. Re-run any time.

> **Note:** First run takes ~15–20 min depending on internet. macOS will ask for your password once (for Homebrew + timezone) and may show dialogs for default browser approval.

---

## 📦 What's installed

### 🧰 CLI Tools (`brew install`)

Modern replacements and essential utilities. All listed in [`brew/non_cask.txt`](brew/non_cask.txt).

| Tool | What it does |
|---|---|
| [**atuin**](https://github.com/atuinsh/atuin) | Encrypted, syncable shell history with fuzzy search (replaces `Ctrl+R`) |
| [**awscli**](https://github.com/aws/aws-cli) | Official AWS command-line interface |
| [**bat**](https://github.com/sharkdp/bat) | `cat` with syntax highlighting and line numbers |
| [**bottom**](https://github.com/ClementTsang/bottom) | Modern `htop` with graphs (`btm`) |
| [**defaultbrowser**](https://github.com/kerma/defaultbrowser) | Set default browser from CLI |
| [**duti**](https://github.com/moretension/duti) | Set default app for file types and URL schemes |
| [**eza**](https://github.com/eza-community/eza) | Modern `ls` with colors, git status, and tree mode |
| [**fd**](https://github.com/sharkdp/fd) | Friendly `find` alternative with intuitive syntax |
| [**ffmpeg**](https://ffmpeg.org/) | Swiss-army knife for video/audio processing |
| [**fzf**](https://github.com/junegunn/fzf) | General-purpose command-line fuzzy finder |
| [**gh**](https://github.com/cli/cli) | GitHub's official command-line tool |
| [**glow**](https://github.com/charmbracelet/glow) | Render Markdown beautifully in the terminal |
| [**gum**](https://github.com/charmbracelet/gum) | Beautiful TUI components (used internally for install UI) |
| [**htop**](https://htop.dev/) | Interactive process viewer |
| [**imagemagick**](https://imagemagick.org/) | Swiss-army knife for image manipulation |
| [**jq**](https://github.com/jqlang/jq) | Command-line JSON processor |
| [**jupyterlab**](https://jupyter.org/) | Web-based notebook environment (includes `jupyter notebook`) |
| [**mas**](https://github.com/mas-cli/mas) | Mac App Store CLI |
| [**neovim**](https://neovim.io/) | Hyperextensible Vim-based text editor |
| [**ripgrep**](https://github.com/BurntSushi/ripgrep) | Ultra-fast `grep` alternative |
| [**tmux**](https://github.com/tmux/tmux) | Terminal multiplexer |
| [**tree**](https://gitlab.com/OldManProgrammer/unix-tree) | Recursive directory listing as a tree |
| [**unzip**](https://infozip.sourceforge.net/UnZip.html) | Modern unzip |
| [**wget**](https://www.gnu.org/software/wget/) | Network downloader |
| [**zip**](https://infozip.sourceforge.net/Zip.html) | Modern zip |
| [**zoxide**](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` that learns your habits (`z foo`) |

### 🖥 GUI Apps (`brew install --cask`)

All listed in [`brew/cask.txt`](brew/cask.txt).

| App | Category |
|---|---|
| [**Brave Browser**](https://brave.com/) | Privacy-first browser |
| [**Claude**](https://claude.com/download) | Anthropic's official desktop AI app |
| [**Claude Code**](https://claude.com/product/claude-code) | Terminal-based AI coding assistant |
| [**Docker Desktop**](https://www.docker.com/products/docker-desktop/) | Container runtime |
| [**iTerm2**](https://iterm2.com/) | Terminal emulator |
| [**Jupyter Notebook QL**](https://github.com/tuxu/nbviewer-app) | QuickLook plugin to preview `.ipynb` in Finder |
| [**KeepingYouAwake**](https://github.com/newmarcel/KeepingYouAwake) | Prevent sleep from menu bar (open-source Amphetamine alternative) |
| [**Notion**](https://www.notion.so/) | Notes and docs |
| [**Postman**](https://www.postman.com/) | API client |
| [**Rectangle**](https://rectangleapp.com/) | Window manager with keyboard shortcuts |
| [**Slack**](https://slack.com/) | Team communication |
| [**Visual Studio Code**](https://code.visualstudio.com/) | Code editor |
| [**WhatsApp**](https://www.whatsapp.com/) | Messaging |
| [**YT Music**](https://github.com/steve228uk/YouTube-Music) | YouTube Music desktop wrapper |

### 🔤 Fonts

| Font | Use |
|---|---|
| [**MesloLGS Nerd Font**](https://github.com/ryanoasis/nerd-fonts) | Recommended font for [powerlevel10k](https://github.com/romkatv/powerlevel10k). Includes all icons used by the prompt |

### 🐚 Shell — Oh My Zsh + plugins

| Plugin | Repo |
|---|---|
| [**powerlevel10k**](https://github.com/romkatv/powerlevel10k) | Lightning-fast prompt with rich info segments |
| [**zsh-autosuggestions**](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like suggestions based on command history |
| [**fast-syntax-highlighting**](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Syntax highlighting while you type |

---

## ⚙️ Configurations applied

### 🪟 macOS system settings

Applied via [`make macos_settings`](Makefile).

| Setting | Value |
|---|---|
| UI Language | English (primary), Spanish (fallback) |
| Locale | `es_CL@currency=CLP` (Chilean date/number formats) |
| Keyboard layouts | U.S. (default) + Latin American |
| Timezone | `America/Santiago` |

### 🎛 macOS sensible defaults

Applied via [`macos/defaults.sh`](macos/defaults.sh). All reversible — see [Reverting changes](#-reverting-changes).

| # | Setting | Why |
|---|---|---|
| 1 | Smart quotes / dashes / autocorrect **OFF** | Stops `"` from becoming `“` `”` (breaks code copy/paste) |
| 2 | Show file extensions + hidden files | See `.dotfiles` in Finder |
| 3 | Screenshots → `~/Downloads` as JPG | Lighter, doesn't clutter Desktop |
| 4 | Fast key repeat + tap-to-click | KeyRepeat=2, InitialKeyRepeat=15 |
| 5 | Finder searches current folder by default | Searching the whole Mac is slow |
| 6 | Dock hides "Recent apps" section | Less clutter |

### 🎨 iTerm2

- **Color preset:** [Atelier Sulphurpool](https://github.com/atelierbram/syntax-highlighting/tree/master/atelier-schemes/output/iterm)
- **Font:** MesloLGS NF Regular 14 with anti-aliasing
- **Method:** [Dynamic Profile](https://iterm2.com/documentation-dynamic-profiles.html) auto-loaded from `~/Library/Application Support/iTerm2/DynamicProfiles/`
- **Default:** Set via `defaults write com.googlecode.iterm2 "Default Bookmark Guid"`

### 🌐 Default browser

[Brave](https://brave.com/) is set as default via [`duti`](https://github.com/moretension/duti) when macOS allows it. Since Big Sur+, macOS protects against silent browser changes — if blocked, Brave is opened so its own "Make default" prompt appears, requiring one click.

### 🐙 Git

See [`git/.gitconfig`](git/.gitconfig). Highlights:

- `init.defaultBranch = main`
- `push.default = simple` + `push.autoSetupRemote = true`
- `pull.rebase = false`
- `fetch.prune = true`
- 30+ aliases (`git l`, `git s`, `git ca`, `git go branch`, etc.)
- `color.ui = auto` with custom color schemes
- `core.editor = code --wait`

### 🐚 Zsh

Configured in [`zsh/`](zsh/). Highlights:

- **`.zshrc`** — minimal entry point: loads `brew shellenv` + p10k instant prompt + `.zshrc.local`
- **`.zshrc.local`** — Oh My Zsh setup, plugins, keybindings, integrations
- **`.zshrc.exports`** — `EDITOR=nvim`, locale, history (50k entries)
- **`.zshrc.aliases`** — git shortcuts (`gst`, `gco`, `gp`), `ls` → `eza`, `cat` → `bat`, etc.
- **`.zshrc.functions`** — utility functions (`tre`, `fs`, `json`)
- **`.p10k.zsh`** — powerlevel10k configuration

Integrations auto-loaded if their binaries are present:
- `eval "$(zoxide init zsh)"` — `z` smart cd
- `eval "$(atuin init zsh --disable-up-arrow)"` — better Ctrl+R history
- `source ~/.fzf.zsh` — fuzzy finder bindings

### 🖥 tmux

See [`tmux/.tmux.conf`](tmux/.tmux.conf) — based on [gpakosz/.tmux](https://github.com/gpakosz/.tmux).

- Prefix changed to `Ctrl+A` (instead of `Ctrl+B`)
- Status bar on top
- Pane navigation with `hjkl` (vim-style)
- Splits with `-` (horizontal) and `_` (vertical)
- Status bar with battery, time, weather
- Configurable via [`tmux/.tmux.conf.local`](tmux/.tmux.conf.local)

### 🤖 Claude Code

Only the **portable** config is versioned (see [`claude/IDEAS.md`](claude/IDEAS.md)). `make claude` symlinks individual files — never the whole `~/.claude`, which holds runtime state.

- [`claude/settings.json`](claude/settings.json) → `~/.claude/settings.json` — permissions, hooks, statusline, plugins, `env`
- [`claude/scripts/block-sleep-polling.py`](claude/scripts/block-sleep-polling.py) → `~/.claude/scripts/` — PreToolUse hook blocking `sleep`/polling in Bash
- [`claude/ccstatusline/settings.json`](claude/ccstatusline/settings.json) → `~/.config/ccstatusline/settings.json` — the status bar **design** (segments, colors, layout)
- A previous real `settings.json` is backed up to `settings.json.dotfiles-bak` before linking
- **Deliberately NOT versioned:** `settings.local.json`, `~/.claude.json`, and all `sessions/`, `history`, `telemetry/`, `cache/` (auth/secrets/runtime)

---

## 📁 Repo structure

```
.
├── Makefile                       # Orchestrates everything
├── README.md
├── brew/
│   ├── cask.txt                   # GUI apps (one per line)
│   ├── non_cask.txt               # CLI tools (one per line)
│   └── from_app_store.txt         # App Store IDs (one per line)
├── claude/
│   ├── settings.json              # Claude Code global config (permissions, hooks, plugins)
│   ├── scripts/
│   │   └── block-sleep-polling.py # PreToolUse hook (blocks sleep/polling)
│   ├── ccstatusline/
│   │   └── settings.json          # Status bar design (segments, colors, layout)
│   └── IDEAS.md                   # What's versioned + future ideas
├── git/
│   ├── .gitconfig                 # Aliases, push/pull settings, identity
│   └── gitignore                  # Global gitignore
├── iterm2/
│   └── AtelierSulphurpool.itermcolors   # Color preset (auto-converted to JSON)
├── macos/
│   └── defaults.sh                # Sensible defaults script
├── tmux/
│   ├── .tmux.conf                 # Base tmux config (gpakosz)
│   └── .tmux.conf.local           # User overrides
└── zsh/
    ├── .zshrc                     # Entry point
    ├── .zshrc.local               # Main config (OMZ + plugins + integrations)
    ├── .zshrc.exports             # Env vars
    ├── .zshrc.alias               # Aliases
    ├── .zshrc.functions           # Functions
    └── .p10k.zsh                  # Powerlevel10k config
```

---

## 🎯 Make targets

| Target | What it does |
|---|---|
| `make install` | Run everything (default) |
| `make brew_install` | Install Homebrew if missing |
| `make brew_packages` | Install/update formulae, casks, and App Store apps |
| `make omz` | Install Oh My Zsh |
| `make plugins` | Clone zsh plugins (p10k + autosuggestions + fast-syntax-highlighting) |
| `make symlinks` | Symlink dotfiles to `~/` |
| `make iterm2` | Register color preset + font as iTerm2 default profile |
| `make default_browser` | Set Brave as default browser |
| `make macos_settings` | Apply language / keyboard / timezone |
| `make macos_defaults` | Apply Finder/Dock/screenshot/keyboard tweaks |
| `make claude` | Symlink Claude Code `settings.json` + hooks (backs up existing) |

Each target is idempotent — safe to re-run.

---

## 🛠 Customization

### Add a CLI tool
Edit [`brew/non_cask.txt`](brew/non_cask.txt), add the formula name (one per line), run `make brew_packages`.

### Add a GUI app
Edit [`brew/cask.txt`](brew/cask.txt), add the cask name, run `make brew_packages`.

### Change shell aliases
Edit [`zsh/.zshrc.alias`](zsh/.zshrc.alias), run `source ~/.zshrc` or open a new terminal.

### Change powerlevel10k prompt
Run `p10k configure` — it rewrites [`zsh/.p10k.zsh`](zsh/.p10k.zsh) via symlink.

### Change iTerm2 colors
Replace [`iterm2/AtelierSulphurpool.itermcolors`](iterm2/) with another `.itermcolors` file, rename it, update the path in [`Makefile`](Makefile), then run `make iterm2`.

### Toggle a sensible default
Edit [`macos/defaults.sh`](macos/defaults.sh), comment/uncomment lines, run `make macos_defaults`.

---

## 🔁 Reverting changes

Almost everything is reversible with `defaults delete`:

```bash
# Re-enable smart quotes
defaults delete NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled

# Move screenshots back to Desktop
defaults delete com.apple.screencapture location
killall SystemUIServer

# Unlink dotfiles
rm ~/.zshrc ~/.zshrc.local ~/.p10k.zsh ~/.tmux.conf ~/.tmux.conf.local ~/.gitconfig ~/.gitignore

# Remove ~/.dotfiles symlink
rm ~/.dotfiles
```

To uninstall a brew package: `brew uninstall <name>` (formula) or `brew uninstall --cask <name>` (cask).

---

## 🐛 Troubleshooting

### Powerlevel10k icons show as squares or `?`
The Nerd Font isn't being used by iTerm2.

```bash
# Verify the font is installed
ls "$HOME/Library/Fonts/" | grep -i meslo

# Open iTerm2 → Settings → Profiles → AtelierSulphurpool → Text
# Make sure Font says "MesloLGS NF Regular"
```

### `defaultbrowser` says `brave is not available as an HTTP handler`
macOS hasn't registered Brave yet. Open Brave once, then re-run `make default_browser`.

### App Store apps fail with `sudo: a password is required`
`mas install` only works for apps already in your library. Open App Store, search the app, click "Get" once, then re-run.

### `mas` says `No apps found in the App Store for ADAM ID …`
The app is iOS-only and `mas` doesn't support iOS apps. Install manually from App Store.

### Brave/Chrome already installed via DMG conflicts with cask
Solved automatically — the Makefile uses `brew install --cask --adopt`, which adopts existing apps instead of failing.

### `make install` aborts on first error
Should not happen — `brew_packages` catches individual failures with `|| echo`. If it does, file an issue with the failing command.

---

## 📚 Credits & inspiration

This repo stands on the shoulders of giants:

- 🌈 [**Mathias Bynens' dotfiles**](https://github.com/mathiasbynens/dotfiles) — the foundational `.macos` reference everyone borrows from
- 🐚 [**Oh My Zsh**](https://github.com/ohmyzsh/ohmyzsh) — the zsh framework that made everything easier
- 💎 [**Powerlevel10k**](https://github.com/romkatv/powerlevel10k) by Roman Perezhok — the fastest, most beautiful zsh theme
- 🎨 [**Atelier color schemes**](https://atelierbram.github.io/syntax-highlighting/atelier-schemes/) by Bram de Haan
- 🖥 [**gpakosz/.tmux**](https://github.com/gpakosz/.tmux) — opinionated tmux config
- 🌟 [**Charm**](https://charm.sh/) — for `gum`, `glow`, and gorgeous TUIs in general
- 🦊 [**Homebrew**](https://brew.sh) — none of this works without it

---

## 📜 License

[MIT](LICENSE) — do whatever you want with this. Steal pieces, fork the whole thing, share with your team.

---

<div align="center">

**Built with care for [Apple Silicon](https://en.wikipedia.org/wiki/Apple_silicon).**

If this saved you time, consider [⭐ starring the repo](https://github.com/so77id/dotfiles).

</div>
