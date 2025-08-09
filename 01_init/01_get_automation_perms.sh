# This script ensures we have system events and assistive access permissions 
# by enabling Dark mode in System Preferences
source "$(dirname "$0")/../util/self_automation_bless.sh"

needs_run() {
  return 0
}

dependencies_met() {
  return 0
}

run() {
  # Maximize terminal size
  self_automation_bless
  osascript -e 'tell application "Terminal" to set bounds of front window to {0,0,1024,768}'

  # Test permissions by enabling dark mode
  self_automation_bless
  osascript -e '
    with timeout of 30 seconds
      tell application "System Preferences"
        activate
        set current pane to pane "com.apple.preference.general"
      end tell

      tell application "System Events"
        repeat until exists of checkbox "Dark" of window "General" of application process "System Preferences"
          delay 0.1
        end repeat

        click checkbox "Dark" of window "General" of application process "System Preferences"
      end tell

      tell application "System Preferences" to quit
    end timeout
  '
}
