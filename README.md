# Hypractivity

A lightweight bash-based activity manager for **Hyprland**, designed to mimic the "Activity" functionality found in KDE Plasma.

This tool allows you to group sets of workspaces and windows into logical "Activities". When you switch activities, all currently open windows are "stashed" into a hidden special workspace. When you switch back, they are restored to their original workspaces.

## How it Works

1. **Activity 1**: You have a Terminal on Workspace 1 and Firefox on Workspace 2.
2. **Switch to Activity 2**: The Terminal and Firefox are moved to a hidden special workspace (`special:act_activity_1`). Activity 2 starts fresh with empty workspaces.
3. **Switch back to Activity 1**: The script identifies the windows stashed for Activity 1 and moves them back: Terminal to Workspace 1, Firefox to Workspace 2.

## Prerequisites

Ensure you have the following installed on your Arch Linux system:

- **Hyprland**: The window manager.
- **jq**: For processing `hyprctl` JSON output.
- **libnotify**: For desktop notifications (`notify-send`).
- **bash-completion**: If you want to use the auto-completion script.

```bash
sudo pacman -S jq libnotify bash-completion
```

## 🛠 Installation

### 1. The Dispatcher Script

Copy the `hypractivity` script content from the app to `~/.config/hypr/scripts/hypractivity` (or any directory in your `$PATH` e.g `/usr/local/bin`).

```bash
mkdir -p ~/.config/hypr/scripts
chmod +x ~/.config/hypr/scripts/hypr-activity
```

or

```bash
# for global access
chmod +x ./hypractivity
sudo cp ./hypractivity /usr/local/bin/hypractivity
```

### 3. Bash Completion

Copy the `completion.sh` content to `~/.config/hypr/scripts/hypractivity-completion.sh` and source it in your shell config:

```bash
# In ~/.bashrc of ~/.zshrc
source ~/.config/hypr/scripts/hypractivity-completion.sh
```

## Usage & Commands

Commands:

```
  next           - Cycle to the next activity
                   (auto-creates if at end)
  prev           - Cycle to the
                   previous activity
  switch <name>  - Switch to a specific
                   activity by name
  list           - List all activities and
                   which one is active
  info <name>    - List windows in a specific
                   activity (sorted by workspace)
  delete <name>  - Delete an activity and all
                   its active windows
```

## Hyprland Keybinds

You can map these commands to gestures or keybinds in your `hyprland.conf`:

```conf
# Example: Script in global PATH
bind = SUPER, TAB, exec, hypr-activity next
bind = SUPER SHIFT, TAB, exec, hypr-activity prev

```

## State Management

The script stores its state in `~/.cache/hypr-activities/`:

- `list`: Plain text list of activity names.
- `current`: The name of the currently active activity.
- `*.map`: Address mapping of windows to their original workspace IDs.
- `*.last_ws`: The last active workspace ID for that activity.
