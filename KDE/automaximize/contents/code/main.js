// View logs with: journalctl -f QT_CATEGORY=js QT_CATEGORY=kwin_scripting

// List of application resource classes to match
// Find class name via: System Settings > Window Management > Window rules > Edit > Detect Window Properties

// Large windows are always maximized
const targetClassesLarge = [
  "wezterm",
  "firefox",
  "chromium",
  "zen",
  "kwrite",
  "kate",
  "beekeeper-studio",
  "alpaca"
];

// Small windows are only maximized on small screens
const targetClassesSmall = [
  "konsole",
  "dolphin",
];

const largeWidth = 1601;
const largeHeight = 901;

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

  let targetClasses = targetClassesLarge;
  if (window.output.geometry.width < largeWidth && window.output.geometry.height < largeHeight) {
    targetClasses.concat(targetClassesSmall);
  };

  // Check if class contains any target substring
  let classMatch = targetClasses.some(substring => {
    window.resourceClass.toLowerCase().includes(substring.toLowerCase())
  });

  if (classMatch) {
    print("→ Match found, maximizing window");
    window.setMaximize(true, true);
  } else {
    print("→ No match, ignoring");
  }
});
