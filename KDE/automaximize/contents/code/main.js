// View logs with: journalctl -f QT_CATEGORY=js QT_CATEGORY=kwin_scripting

// List of application resource classes to match
// Find class name via: System Settings > Window Management > Window rules > Edit > Detect Window Properties
const targetClasses = [
  "konsole",
  "wezterm",
  "dolphin",
  "firefox",
  "chromium",
  "zen",
  "kwrite",
  "kate",
  "beekeeper-studio",
  "alpaca"
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

  // Check if class contains any target substring
  let classMatch = targetClasses.some(substring =>
    window.resourceClass.toLowerCase().includes(substring.toLowerCase())
  );

  if (classMatch || titleMatch) {
    print("→ Match found, maximizing window");
    window.setMaximize(true, true);
  } else {
    print("→ No match, ignoring");
  }
});
