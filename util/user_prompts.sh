# AppleScript dialogs timeout pretty quickly (1-2 mins), and manually setting the timeout disables this

prompt() {
  if [ "$TEST_ENVIRONMENT" = "true" ] ; then ; return 0 ; fi
  osascript -e "
    with timeout of 99999999 seconds
      tell app \"System Events\"
        display dialog \"${1}\" buttons {\"Next\"} default button 1 with title \"${2:-"AppFolio Setup Script"}\"
      end tell
    end timeout
  "
}

prompt_for_text() {
  if [ "$TEST_ENVIRONMENT" = "true" ] ; then ; return 1 ; fi
  osascript -e "
    with timeout of 99999999 seconds
      tell app \"System Events\"
        text returned of (display dialog \"${1}\" default answer \"\" buttons {\"Next\"} default button 1 with title \"${2:-"AppFolio Setup Script"}\")
      end tell
    end timeout
  "
}

prompt_for_text_secret() {
  if [ "$TEST_ENVIRONMENT" = "true" ] ; then ; return 1 ; fi
  osascript -e "
    with timeout of 99999999 seconds
      tell app \"System Events\"
        text returned of (display dialog \"${1}\" with hidden answer default answer \"\" buttons {\"Next\"} default button 1 with title \"${2:-"AppFolio Setup Script"}\")
      end tell
    end timeout
  "
}
