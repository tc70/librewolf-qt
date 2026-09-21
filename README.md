# LibreWolf KDE Plasma & Qt Integration Guide

This repository provides configuration templates, documentation, and automated setup scripts to seamlessly integrate **LibreWolf** with **Qt**.

---

## Technical Context: LibreWolf, GTK, and Qt

LibreWolf is built on Mozilla Firefox's rendering engine (Gecko) and Mozilla's platform abstraction layer (`widget/gtk`). While Mozilla had an experimental Qt port (`widget/qt`) many years ago, it was ultimately not the path that became widely used or maintained.

**However, you do NOT need a native Qt port of LibreWolf to get full, seamless KDE Plasma integration**

By configuring KDE Plasma's GTK bridge components, XDG Desktop Portals, and Firefox preferences, LibreWolf achieves:
1. **Global Menu (Mac-style / Plasma Top Bar Menu Bar):** Exports LibreWolf's menu bar over DBus (`org.canonical.dbusmenu`) to KDE's Global Menu widget.
2. **Native KDE / KWin Titlebar & Window Decorations:** Uses native KWin window titlebars and window control buttons matching your KDE Plasma theme.
3. **KDE Native File Dialogs (Dolphin / KIO):** Uses `xdg-desktop-portal-kde` for opening and saving files instead of GTK file choosers.
4. **Plasma Browser Integration:** Full integration with Plasma media controls, download notifications, and KRunner.

---

## Quick Setup (Automated Script)

Run the included setup script to configure your user environment and LibreWolf profile automatically:

```bash
chmod +x setup-kde-integration.sh
./setup-kde-integration.sh
```

---

## Manual Step-by-Step Configuration

### 1. Install Required Packages

Use the commands below for your distro. The KDE portal, GTK appmenu module, and Plasma integration packages are the important pieces for desktop integration.

#### Arch Linux / Artix Linux

```bash
# Arch / Artix (pacman)
sudo pacman -S --needed \
    appmenu-gtk-module \
    xdg-desktop-portal \
    xdg-desktop-portal-kde \
    plasma-browser-integration
```

#### Fedora / RHEL / CentOS Stream

```bash
sudo dnf install \
    appmenu-gtk-module \
    xdg-desktop-portal \
    xdg-desktop-portal-kde \
    plasma-browser-integration
```

#### Debian / Ubuntu / Linux Mint / Pop!_OS

```bash
sudo apt install \
    appmenu-gtk-module \
    xdg-desktop-portal \
    xdg-desktop-portal-kde \
    plasma-browser-integration
```

#### openSUSE

```bash
sudo zypper install \
    appmenu-gtk-module \
    xdg-desktop-portal \
    xdg-desktop-portal-kde \
    plasma-browser-integration
```

#### Void Linux

```bash
sudo xbps-install \
    appmenu-gtk-module \
    xdg-desktop-portal \
    xdg-desktop-portal-kde \
    plasma-browser-integration
```

If your distro packages have slightly different names, look for the equivalent `appmenu-gtk-module`, `xdg-desktop-portal`, `xdg-desktop-portal-kde`, and `plasma-browser-integration` packages.

### 2. Enable Global Menu Export for GTK Apps

To export GTK app menus to KDE's Global Menu widget, set the `GTK_MODULES` environment variable.

Add the following to `~/.config/environment.d/10-gtk-modules.conf` or `~/.xprofile` / `~/.bashrc` / `~/.zshrc`:

```bash
export GTK_MODULES="appmenu-gtk-module"
```

*Note: Restart your desktop session or reboot after setting environment variables.*

### 3. Native Titlebars and Window Controls

To use native KDE/KWin titlebars instead of CSD (Client-Side Decoration / Client Headerbar):

1. Open **LibreWolf**.
2. Right-click on empty space in the tab bar or toolbar and select **Customize Toolbar...**.
3. In the bottom-left corner, **check the "Title Bar" checkbox**.
4. Click **Done**.

Alternatively, set the following preference in `about:config` or `user.js`:
- `browser.tabs.inTitlebar` = `0` (or `1` if you prefer unified titlebar with KDE controls).

### 4. Enable KDE Native File Pickers

To force LibreWolf to use KDE's `KFileWidget` dialogs (Dolphin file chooser) via XDG Desktop Portal:

1. Open `about:config` in LibreWolf.
2. Search for `widget.use-xdg-desktop-portal.file-picker`.
3. Set its value to `1` (Always use portal) or `2` (Auto-detect desktop environment).

### 5. Plasma Browser Integration

1. Ensure `plasma-browser-integration` package is installed on your system.
2. Install the **Plasma Browser Integration** extension in LibreWolf from Firefox Add-ons.
3. This syncs tab audio/media with KDE Plasma system tray volume applet, media controls widget, and notification center.

---

## Repository Files

- `user.js`: Pre-configured preference file containing KDE-optimized settings for LibreWolf profiles.
- `setup-kde-integration.sh`: Shell script that automates package checking, environment variable configuration, and `user.js` deployment.
- `README.md`: This guide.
