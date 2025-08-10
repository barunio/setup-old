source "$(dirname $0)/../util/echo_colors.sh"
source "$(dirname $0)/../util/user_prompts.sh"

needs_run() {
  ! (
    expect <<< "
      set timeout 30
      spawn git ls-remote https://github.com/appfolio/apm_bundle.git
      expect {
        \"Username for 'https://github.com':\" {
          send \"\x03\"
          exit 1
        }
      }

      catch wait result
      exit [lindex \$result 3]
  " > /dev/null && (
    gem list -r -e "afshell" --source "https://rubygems.pkg.github.com/appfolio/" | grep -q afshell
  ))
}

dependencies_met() {
  return 0
}

run() {
  username_prompt="Enter your GitHub username:\n\n"
  username_prompt+="(The account needs to have already joined the AppFolio org on GitHub.)"
  while [ -z "${github_username}" ]; do
    github_username="$(prompt_for_text "$username_prompt")"
  done
  

  token_prompt='Enter your GitHub access token:\n\n'
  token_prompt+='More info:\nhttps://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token\n\n'
  token_prompt+='The token needs the \"repo\", \"write:packages\", and \"read:packages\" permissions. Once generated, make sure to enable SSO for this token on the AppFolio org.'
  while [ -z "${github_token}" ]; do
    github_token="$(prompt_for_text_secret "$token_prompt")"
  done
  

  # Test the keys to make sure they work
  git ls-remote https://$github_username:$github_token@github.com/appfolio/apm_bundle.git > /dev/null
  gem list -r -e "afshell" --source "https://$github_username:$github_token@rubygems.pkg.github.com/appfolio/" | grep -q afshell

  # Save the credentials
  git credential-osxkeychain store <<< "
    protocol=https
    host=github.com
    username=$github_username
    password=$github_token
  "

  # https://sites.google.com/a/appfolio.com/eng/resources/code/gem-development-procedures-in-git#TOC-Configuring-Github-Packages
  mkdir -p ~/.gem/
  echo ":github: Bearer $github_token" >> ~/.gem/credentials
  bundle config rubygems.pkg.github.com "$github_username:$github_token"
  gem sources --add "https://$github_username:$github_token@rubygems.pkg.github.com/appfolio/" |& sed "s/$github_token/<token>/g"

  # https://appfolio.slack.com/archives/C02A9D6U3/p1619733146088000
  # https://sites.google.com/a/appfolio.com/eng/resources/front-end-development/npm
  echo 'export NPM_TOKEN="bnBtLXJlYWQtb25seS0yOlEzaTEmN2pZREU3R2NGdA=="' >> ~/.zshrc
  echo "export GITHUB_NPM_TOKEN=\"$github_token\"" >> ~/.zshrc
}
