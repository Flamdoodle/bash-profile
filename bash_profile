export PATH=/usr/local/bin:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Look at http://alias.sh/ for more fun things like this

# For rubby development
which -s bundle && alias be="bundle exec"

# Open github web page of current git repo
alias github="open https://github.$(git config remote.origin.url | cut -f2 -d.)"

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
alias gph='git push heroku master'
alias gb='git branch'
alias gpum='git pull origin master'
alias gpuo='git pull origin'
function publish() {
  gbranch='git branch'
  git push origin $gbranch
}

# Some tests with database commands in development
alias boom='be rake db:drop; be rake db:create && be rake db:migrate'
alias seed='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed'
alias booms='be rake db:drop; be rake db:create && be rake db:migrate && rails s'
alias seeds='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed && rails s'

# Opens bash profile
alias bp='subl ~/.bash_profile'

# Creates regenerating Jekyll server
alias js='jekyll serve --watch'

# Shows name (in cyan), current working directory (in green), current branch (in pink)
PS1='\[\e[1;96m\]\u: \[\e[0;32m\]\W \[\033[00m\]$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "\[\e[0;35m\][$(git branch | grep ^*|sed s/\*\ //)] \[\033[00m\]"; fi)>> '

# grab git branch & branch autocomplete
parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Some aliases for great purpose!
alias desk='cd ~/Desktop'
alias ls='ls -GFh'
alias code='cd ~/Documents/Projects'
alias reload='source ~/.bash_profile'
alias f='open -a Finder ./'                 # Opens current directory in MacOS Finder

# Case insensitive tabbing
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"