source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/self_automation_bless.sh"
source "$(dirname $0)/../util/user_prompts.sh"

needs_run() {
  ! cat ~/Library/Containers/com.sequel-ace.sequel-ace/Data/Library/Preferences/com.sequel-ace.sequel-ace.plist | grep -q "$(realpath ~/.ssh/config)"
}

dependencies_met() {
  if ! brew list --cask | grep -q sequel-ace; then
    echo_danger "Configuring Sequel Ace requires it already be installed."
    return 1
  fi
}

run() {
  prompt_text="When you click next, Sequel Ace will open and automatically be configured "
  prompt_text+="to use the AppFolio SSH configuration. Please keep your hands off the "
  prompt_text+="computer until Sequel Ace closes (should only be ~10 seconds)."
  prompt "$prompt_text"

  # Default the Sequel Ace SSH config to the above AppFolio SSH config
  PLIST_LOCATION=~/Library/Containers/com.sequel-ace.sequel-ace/Data/Library/Preferences/com.sequel-ace.sequel-ace.plist
  plutil -replace known_hosts -integer 0 "$PLIST_LOCATION"
  plutil -replace ssh_config -string "$(realpath ~/.ssh/config)" "$PLIST_LOCATION"
  plutil -replace SPSecureBookmarks -xml \
    "<array><dict><key>file://$(realpath ~/.ssh/config)</key><data>stale</data></dict><dict><key>file://$(realpath ~/.ssh/id_rsa)</key><data>stale</data></dict></array>" \
    "$PLIST_LOCATION"

  # Give Sequel Ace access to the SSH config files
  open "/Applications/Sequel Ace.app" && sleep 2
  osascript -e "
    tell application \"System Events\"
      click UI Element \"Yes\" of window 1 of application process \"Sequel Ace\"
      delay 1

      activate app \"Sequel Ace\"
      delay 0.5

      tell window \"Open\" of application process \"Sequel Ace\"
        keystroke \"G\" using {command down, shift down}
        delay 1
        keystroke \"~/.ssh/id_rsa\"
        delay 1
        keystroke return
        delay 1
        click UI Element \"Open\"
      end tell
      delay 1

      activate app \"Sequel Ace\"
      delay 0.5

      tell window \"Open\" of application process \"Sequel Ace\"
        keystroke \"G\" using {command down, shift down}
        delay 1
        keystroke \"~/.ssh/config\"
        delay 1
        keystroke return
        delay 1
        click UI Element \"Open\"
      end tell
      delay 1

      tell app \"Sequel Ace\" to quit
    end tell
  "
}
