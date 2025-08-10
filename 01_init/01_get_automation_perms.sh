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
      tell application "System Settings" to activate

      tell application "System Events"
        repeat until exists window "System Settings" of application process "System Settings"
          delay 0.1
        end repeat

        tell application process "System Settings"
          click menu item "Trackpad" of menu "View" of menu bar item "View" of menu bar 1

          delay 0.5

          click radio button "Scroll & Zoom" of tab group 1 of group 1 of window "Trackpad"

          delay 0.5

          set theCheckbox to checkbox "Scroll direction: Natural" of tab group 1 of group 1 of window "Trackpad"
          if value of theCheckbox as boolean is true then
            click theCheckbox
          end if
        end tell
      end tell

      tell application "System Settings" to quit
    end timeout
  '
}
