# AVIT ZSH Theme modified for Github Light colors

# settings
typeset +H _current_dir="%{$fg_bold[black]%}%3~%{$reset_color%} "
typeset +H _return_status="%{$fg_bold[red]%}%(?..⍉)%{$reset_color%}"
typeset +H _hist_no="%{$fg[black]%}%h%{$reset_color%}"

PROMPT='
$(_user_host)${_current_dir} $(git_prompt_info)
%{%(!.${fg[red]}.${fg[black]})%}▶%{$reset_color%} '

PROMPT2='%{%(!.${fg[red]}.${fg[black]})%}◀%{$reset_color%} '

__RPROMPT='$(vi_mode_prompt_info)%{$(echotc UP 1)%}$(_git_time_since_commit) $(git_prompt_status) ${_return_status}%{$(echotc DO 1)%}'
if [[ -z $RPROMPT ]]; then
  RPROMPT=$__RPROMPT
else
  RPROMPT="${RPROMPT} ${__RPROMPT}"
fi

function _user_host() {
  local me
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USERNAME ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[blue]%}$me%{$reset_color%}:"  # Changed to blue (#005cc5)
  fi
}

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
  local last_commit now seconds_since_last_commit
  local minutes hours days years commit_age
  # Only proceed if there is actually a commit.
  if last_commit=$(command git -c log.showSignature=false log --format='%at' -1 2>/dev/null); then
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((minutes / 60))
    days=$((hours / 24))
    years=$((days / 365))

    if [[ $years -gt 0 ]]; then
      commit_age="${years}y$((days % 365 ))d"
    elif [[ $days -gt 0 ]]; then
      commit_age="${days}d$((hours % 24))h"
    elif [[ $hours -gt 0 ]]; then
      commit_age+="${hours}h$(( minutes % 60 ))m"
    else
      commit_age="${minutes}m"
    fi

    echo "${ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL}${commit_age}%{$reset_color%}"
  fi
}

MODE_INDICATOR="%{$fg_bold[magenta]%}❮%{$reset_color%}%{$fg[magenta]%}❮❮%{$reset_color%}"

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"  # #22863a
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"  # #d73a49
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"  # #22863a
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "  # #22863a
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[orange]%}⚑ "  # #e36209
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "  # #d73a49
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "  # #005cc5
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}§ "  # #6f42c1
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[black]%}◒ "  # #000000


# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"  # #22863a
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[orange]%}"  # #e36209
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"  # #d73a49
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[black]%}"  # #000000

# LS colors, adapted for Github Light theme
export LSCOLORS="axfxcxdxbxegedabagacad"
#          Directory:                ex (blue on default)
#          Symlink:                 fx (magenta on default)
#          Socket:                  cx (green on default)
#          Pipe:                    dx (brown/orange on default)
#          Executable:              bx (red on default)
#          Block:                   eg (blue on cyan)
#          Character:               ed (blue on brown)
#          Setuid:                  ab (black on red)
#          Setgid:                  ag (black on cyan)
#          Sticky Other Writable:   ac (black on green)
#          Other Writable:          ad (black on brown)
export LS_COLORS='di=1:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLORS='mt=1;33'

# For zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6a737d'  # Using a grey color from Github Light them0e

# For zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=#000000'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#b31d28'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#d73a49'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#22863a'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#22863a'
ZSH_HIGHLIGHT_STYLES[function]='fg=#6f42c1'
ZSH_HIGHLIGHT_STYLES[command]='fg=#22863a'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#22863a,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#000000'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#22863a'
ZSH_HIGHLIGHT_STYLES[path]='fg=#005cc5'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#005cc5'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#e36209'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#005cc5'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#6f42c1'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#000000'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#000000'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#032f62'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#032f62'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#032f62'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#032f62'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#6f42c1'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#6f42c1'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#6f42c1'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#000000'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#000000'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6a737d'