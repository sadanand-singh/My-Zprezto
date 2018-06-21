#
# Defines Pacman aliases.
#
# Authors:
#   Benjamin Boudreau <dreurmail@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Tips:
#   https://wiki.archlinux.org/index.php/Pacman_Tips
#

# Return if requirements are not found.
if (( ! $+commands[pacman] )); then
  return 1
fi

#
# Frontend
#

# Get the Pacman frontend.
zstyle -s ':prezto:module:pacman' frontend '_pacman_frontend'

if (( $+commands[$_pacman_frontend] )); then
  alias pacman="$_pacman_frontend"
else
  _pacman_frontend='pacman'
  _pacman_sudo='sudo '
fi

#
# Aliases
#

# Pacman.
alias pac="${_pacman_frontend}"

# Installs packages from repositories.
alias paci="${_pacman_sudo}${_pacman_frontend} -S"

# Installs packages from files.
alias pacI="${_pacman_sudo}${_pacman_frontend} -U"

# Removes packages and unneeded dependencies.
alias pacx="${_pacman_sudo}${_pacman_frontend} -R"

# Removes packages, their configuration, and unneeded dependencies.
alias pacX="${_pacman_sudo}${_pacman_frontend} -Rns"

# Displays information about a package from the repositories.
alias pacq="${_pacman_frontend} -Si"

# Displays information about a package from the local database.
alias pacQ="${_pacman_frontend} -Qi"

# Searches for packages in the repositories.
alias pacs="${_pacman_frontend} -Ss"

# Searches for packages in the local database.
alias pacS="${_pacman_frontend} -Qs"

# Lists orphan packages.
alias pacman-list-orphans="${_pacman_sudo}${_pacman_frontend} -Qdt"

# Removes orphan packages.
alias pacman-remove-orphans="${_pacman_sudo}${_pacman_frontend} -Rs \$(${_pacman_frontend} -qQdt)"

# Synchronizes the local package and Arch Build System databases against the
# repositories.
if (( $+commands[abs] )); then
  alias pacu="${_pacman_sudo}${_pacman_frontend} -Sy && sudo abs update"
else
  alias pacu="${_pacman_sudo}${_pacman_frontend} -Sy"
fi

# Synchronizes the local package database against the repositories then
# upgrades outdated packages.
alias pacU="${_pacman_sudo}${_pacman_frontend} -Syu"

function aurget {
  local target_dir="$1"
  if [[ -n "$2" ]]; then
    target_dir="$2"
  fi
  git clone "https://aur.archlinux.org/$1" "$target_dir"
}

unset _pacman_{frontend,sudo}
