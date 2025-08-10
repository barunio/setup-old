source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/user_prompts.sh"

needs_run() {
  ! expect <<< "
      set timeout 30
      spawn git ls-remote org-115119@github.com:appfolio/apm_bundle.git
      expect {
        -re \".*nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.*\" {
          send \"yes\r\"
          exp_continue
        }
        -re \"Enter passphrase for key.*\" {
          exit 1
        }
      }

      catch wait result
      exit [lindex \$result 3]
  " > /dev/null
}

dependencies_met() {
  return 0
}

run() {
  open -a TextEdit ~/.ssh/id_rsa.pub
  prompt_text="Please copy/paste the SSH key that just opened in TextEdit "
  prompt_text+="and add it to your GitHub account (in Settings > SSH & GPG Keys), "
  prompt_text+="and then enable SSO for this key. When you're finished, "
  prompt_text+="close TextEdit and click next."
  prompt $prompt_text

  # Test access
  git ls-remote org-115119@github.com:appfolio/apm_bundle.git > /dev/null
}
