// LibreWolf user.js - KDE Plasma & Qt Desktop Integration Preferences

// Force XDG Desktop Portal for native KDE file picker dialogs (Dolphin/KIO)
// 0: Never, 1: Always, 2: Auto-detect desktop environment
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
user_pref("widget.use-xdg-desktop-portal.mime-handler", 1);
user_pref("widget.use-xdg-desktop-portal.location", 1);
user_pref("widget.use-xdg-desktop-portal.open-uri", 1);

// Titlebar & Window Decoration Preferences
// 0: Always display native KWin titlebar
// 1: Client-Side Decoration (CSD / Draw in titlebar)
// 2: System titlebar in windowed mode, CSD in maximized mode
user_pref("browser.tabs.inTitlebar", 0);

// Use System Dark / Light Theme matching KDE Plasma color scheme
user_pref("layout.css.prefers-color-scheme.content-override", 2); // 0: Dark, 1: Light, 2: System

// Enable native UI widget styling where applicable
user_pref("widget.content.allow-gtk-dark-theme", true);
