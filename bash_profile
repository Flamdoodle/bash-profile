# Awesome website for shell scripts: http://explainshell.com/

export PATH=/usr/local/bin:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Look at http://alias.sh/ for more fun things like this

# For rubby development
which -s bundle && alias be="bundle exec"

# Open github web page of current git repo ... broken again
function chromehub() {
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
alias gph='git checkout master && git push heroku master'
alias gb='git branch'
alias gpum='git pull origin master'
alias gpuo='git pull origin'
function publish() {
  gbranch="`git branch &>/dev/null`"
  git push origin $gbranch
}
alias gac='git add . && git commit -vm'
alias gd='git diff'
alias gpud='git pull origin development'

# Some tests with database commands in development
alias boom='be rake db:drop; be rake db:create && be rake db:migrate'
alias seed='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed'
alias booms='be rake db:drop; be rake db:create && be rake db:migrate && rails s'
alias seeds='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed && rails s'

# Clones a repo and CDs into it. From: https://github.com/stephenplusplus/dots/blob/master/.bash_profile
function clone {
  local url=$1;
  local repo=$2;

  if [[ ${url:0:4} == 'http' || ${url:0:3} == 'git' ]]
  then
    # just clone this thing.
    repo=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
  elif [[ -z $repo ]]
  then
    # my own stuff.
    repo=$url;
    url="git@github.com:flamdoodle/$repo";
  else
    # not my own, but I know whose it is.
    url="git@github.com:$url/$repo.git";
  fi

  git clone $url $repo && cd $repo && subl . && bundle install;
}
# Opens bash profile
alias bp='subl ~/.bash_profile'

# Opens .gitconfig
alias gf='subl ~/.gitconfig'

# Creates regenerating Jekyll server
alias js='jekyll serve --watch'

# Shows name (in cyan), current working directory (in green), current branch (in pink)
PS1='\[\e[1;96m\]\u: \[\e[0;32m\]\W \[\033[00m\]$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "\[\e[0;35m\][$(git branch | grep ^*|sed s/\*\ //)] \[\033[00m\]"; fi)>> '

# grab git branch & branch autocomplete
# link to blog post helping with this: http://buddylindsey.com/adding-git-autocomplete-to-bash-on-os-x/

# if curl command doesn't work, just go to url given and manually create and save file

if [ -f ~/git-completion.bash ]; then
  . ~/git-completion.bash
fi

# Allows use with aliases(?)
# Guide: https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Git branch details
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Some aliases for great purpose!
alias desk='cd ~/Desktop'
alias ls='ls -GFh'
alias code='cd ~/Documents/Projects'
alias smart='cd ~/Documents/Projects/smartipants && subl .'
alias whats='cd ~/Documents/Projects/whats-this-2.0 && subl .'
alias bashp='cd ~/Documents/Projects/bash_profile && subl bash_profile'
alias blog='cd ~/Documents/Projects/flamdoodle-blog && subl .'
alias reload='source ~/.bash_profile'
alias f='open -a Finder ./'                 # Opens current directory in MacOS Finder
alias b='bundle install'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'

# Case insensitive tabbing
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"