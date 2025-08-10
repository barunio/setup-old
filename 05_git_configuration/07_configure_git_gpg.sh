source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/user_prompts.sh"

needs_run() {
  return 0
}

dependencies_met() {
  gpg_key_id=$(gpg --list-secret-keys --with-colons | grep 'sec:u:4096' | tail -1 | cut -d ':' -f5)
  if ! [ "${#gpg_key_id}" = "16" ]; then
    echo_danger "Couldn't find a GPG key ID."
    return 1
  fi
}

run() {
  gpg_key_id=$(gpg --list-secret-keys --with-colons | grep 'sec:u:4096' | tail -1 | cut -d ':' -f5)
  gpg --armor --export "$gpg_key_id" > ~/Desktop/.gpg.pub
  
  git config --global gpg.program gpg
  git config --global commit.gpgsign true
  git config --global user.signingkey $gpg_key_id

  open -a TextEdit ~/Desktop/.gpg.pub
  prompt_text="On the same page you added your SSH key to your GitHub account (in Settings > SSH & GPG Keys), "
  prompt_text+="scroll down and add the GPG key that just opened in TextEdit (copy/paste)."
  prompt_text+="\n\nWhen you're finished, close TextEdit and click next."
  prompt $prompt_text
  rm -f ~/Desktop/.gpg.pub
}

