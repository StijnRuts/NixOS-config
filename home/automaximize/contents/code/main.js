// View logs with: journalctl -f QT_CATEGORY=js QT_CATEGORY=kwin_scripting

// In order to obtain log information for KWin scripts, QT_LOGGING_RULES="kwin_*.debug=true" must be set in your environment.
// Open kdebugsettings and ensure KWin Scripting is set to Full Debug. If you are still not getting any output, try adding
// export QT_LOGGING_RULES="kwin_*.debug=true"
// to your ~/.bash_profile or /etc/environment and relogin.

// List of application resource classes to match
// Find class name via: System Settings > Window Management > Window rules > Edit > Detect Window Properties
const targetClasses = [
  "konsole",
  "wezterm",
  "dolphin",
  "neovide",
  "firefox",
  "kwrite",
  "kate",
  "libreoffice",
  "gimp",
  "krita",
  "inkscape",
  "beekeeper-studio",
  "alpaca"
];

// List of titles to match
const targetTitles = [
  "Foobar"
];

print("Auto Maximize loaded");

workspace.windowAdded.connect(function(window) {
  // Log basic info
  print("New window detected:");
  print(" Class: " + window.resourceClass);
  print(" Title: " + window.caption);
  print(" Transient: " + window.transient);

  // Skip transient windows (dialogs, popups)
  if (window.transient) {
    print("→ Skipped (transient)");
    return;
  }

  // Normalize class name
  let appClass = window.resourceClass.toLowerCase();

  // Check if class matches exactly
  // let classMatch = targetClasses.includes(appClass);

  // Check if class contains any target substring
  let classMatch = targetClasses.some(substring =>
    window.resourceClass.toLowerCase().includes(substring.toLowerCase())
  );

  // Check if title contains any target substring
  let titleMatch = targetTitles.some(substring =>
    window.caption.toLowerCase().includes(substring.toLowerCase())
  );

  if (classMatch || titleMatch) {
    print("→ Match found, maximizing window");
    window.setMaximize(true, true);
  } else {
    print("→ No match, ignoring");
  }
});
