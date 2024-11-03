# ohmyzsh 
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="edvardm"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# force default git to english
alias git="LC_ALL=C git"

# navigation 
alias coding="cd $HOME/documents/coding"
alias ricing="cd $HOME/.config/nvim && nvim"

function o() {
  local project_path="$HOME/Documents/coding/$1"

  if [ -d "$project_path" ]; then
    cd "$project_path" && nvim
  else 
    echo "Project does not exist"
  fi
}

# git 
function cc() {
  if [ -z "$1" ]; then 
    echo "You must specifiy a commit message"
    return 1
  fi

  git add .
  git commit -m "$1"

  local branch_name=$(git branch --show-current)
  
  # check if there's an error getting the upstream. if there's none assigned, assign it to `origin/"$branch_name"`
  if [ git rev-parse --abbrev-ref "$current_branch@{upstream}" > /dev/null 2>&1 ]; then
    git push
  else 
    git push -u origin "$branch_name"
  fi
}

function b() {
  if [ -z "$1" ]; then
    echo "You must specify a branch name" 
    return 1
  fi

  git branch "$1" && git checkout "$1"
}
