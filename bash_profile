export PATH=/usr/local/bin:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### BELOW THIS LINE ARE EXPERIMENTS MADE ON JULY 11
### Look at http://alias.sh/ for more

# For rubby development
which -s bundle && alias be="bundle exec"

# Open GitHub webpage of current git repo
function github() {
  local github_url

  if ! git remote -v >/dev/null; then
    return 1
  fi

  # get remotes for fetch
  github_url="`git remote -v | grep github\.com | grep \(fetch\)$`"

  if [ -z "$github_url" ]; then
    echo "A GitHub remote was not found for this repository."
    return 1
  fi

  # look for origin in remotes, use that if found, otherwise use first result
  if [ "echo $github_url | grep '^origin' >/dev/null 2>&1" ]; then
    github_url="`echo $github_url | grep '^origin'`"
  else
    github_url="`echo $github_url | head -n1`"
  fi

  github_url="`echo $github_url | awk '{ print $2 }' | sed 's/git@github\.com:/http:\/\/github\.com\//g'`"
  open $github_url
}
# Make and cd into a directory
function mcd() {
  mkdir -p "$1" && cd "$1";
}

# Find a string in the entire git history
alias gitsearch='git rev-list --all | xargs git grep -F'

# Some tests with git common commands
alias gc='git commit -vm'
alias ga='git add'
alias gr='git rm'
alias gs='git status'
alias gco='git checkout'
alias gcom='git checkout master'
alias gpo='git push origin'
alias gp='git push'
alias gph='git push heroku'
alias gb='git branch'

# Some tests with database commands in development
alias boom='be rake db:drop; be rake db:create && be rake db:migrate'
alias seed='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed'
alias booms='be rake db:drop; be rake db:create && be rake db:migrate && rails s'
alias seeds=alias booms='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed && rails s'

# Opens bash profile
alias bp='subl ~/.bash_profile'

# Creates regenerating Jekyll server
alias js='jekyll serve --watch'