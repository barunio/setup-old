# Automatically clicks the "Ok" button for the "Terminal wants access to control [app]" prompt

check_system_events_permission() {
  # Trigger the "System Events" permission prompt if necessary.
  # Should only trigger a prompt once.

  osascript -e '
    tell application "System Events"
      key down {shift}
      key up {shift}
    end tell  
  '
}

self_automation_bless() {
  check_system_events_permission

  echo "Waiting for an access control prompt..."

  # Backgrounded osascript sometimes causes the script (wait) to hang; namely on vmware. Passing stdout and stdin 
  # to /dev/null and disowning the process (&!) helps prevent this: https://stackoverflow.com/a/56384999
  osascript -e "
    with timeout of ${1:-10} seconds
      tell application \"System Events\"
        repeat until exists of UI Element \"OK\" of front window of application process \"UserNotificationCenter\"
          delay 0.1
        end repeat

        click UI Element \"OK\" of front window of application process \"UserNotificationCenter\"
      end tell
    end timeout
    
    tell me to \"exit\"
  " < /dev/null > /dev/null 2>&1 &!
  sleep 1
}

bypass_gatekeeper_prompt() {
  echo "Waiting 60 seconds for a gatekeeper prompt - if none, will skip."

  if timeout 60 osascript -e '
    tell application "System Events"
      repeat until (exists UI Element "Open" of front window of application process "CoreServicesUIAgent")
        delay 0.1
      end repeat
    end tell
  ' ; then
    self_automation_bless
    osascript -e '
      tell application "System Events"
        tell front window of application process "CoreServicesUIAgent" to click UI Element "Open"
      end tell
    '
  fi
}
