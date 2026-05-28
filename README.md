# ghostty-focus

A GNOME Shell extension + helper script that lets you **focus the Ghostty terminal with a single keypress** — or launch it if it isn't running yet.

## How it works

- `ghostty-focus@local/` — a GNOME Shell extension that exports a D-Bus method. When called, it finds the Ghostty window and brings it to the foreground.
- `ghostty-raise` — a shell script you bind to a hotkey. It calls the extension over D-Bus if Ghostty is already running, or launches Ghostty fresh if it isn't.

## Requirements

- GNOME Shell 45 or later
- [Ghostty](https://ghostty.org) terminal emulator
- `gdbus` (part of `glib2`, available by default on Fedora/Ubuntu/Arch)

## Installation

### 1. Install the GNOME Shell extension

The extension directory name must match its UUID (`ghostty-raise@local`):

```bash
cp -r ghostty-focus@local ~/.local/share/gnome-shell/extensions/ghostty-raise@local
```

Then enable it:

```bash
gnome-extensions enable ghostty-raise@local
```

If GNOME Shell doesn't pick it up immediately, reload it:

```bash
# On Wayland, log out and back in.
# On X11 you can reload in place:
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…", global.context)'
```

### 2. Install the helper script

```bash
cp ghostty-raise ~/.local/bin/ghostty-raise
chmod +x ~/.local/bin/ghostty-raise
```

Make sure `~/.local/bin` is in your `PATH`. Add this to `~/.bashrc` / `~/.zshrc` / `~/.config/fish/config.fish` if it isn't already:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### 3. Bind it to a keyboard shortcut

In **GNOME Settings → Keyboard → Custom Shortcuts**, add a new shortcut:

| Field   | Value                           |
|---------|---------------------------------|
| Name    | Focus Ghostty                   |
| Command | `/home/<you>/.local/bin/ghostty-raise` |
| Shortcut| e.g. `Super+Return`             |

Or set it from the terminal:

```bash
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/ \
  name 'Focus Ghostty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/ \
  command "$HOME/.local/bin/ghostty-raise"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/ \
  binding '<Super>Return'
```

## Usage

Press your configured shortcut:

- If Ghostty is **running** → its window is raised and focused.
- If Ghostty is **not running** → it launches in the background.

## Uninstalling

```bash
gnome-extensions disable ghostty-raise@local
rm -rf ~/.local/share/gnome-shell/extensions/ghostty-raise@local
rm ~/.local/bin/ghostty-raise
```
