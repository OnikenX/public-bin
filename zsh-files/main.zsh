source ~/.local/bin/public-bin/zsh-files/gh.zsh
source ~/.local/bin/public-bin/zsh-files/windows.zsh
source ~/.local/bin/public-bin/zsh-files/alias.zsh
source ~/.local/bin/public-bin/zsh-files/variables.zsh

### adds to the path


if [ -d "$HOME/.cargo/bin" ]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi


if [ -d "$HOME/.local/bin/public-bin" ]; then
    export PATH=$HOME/.local/bin/public-bin:$PATH
    #/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/cmdline-tools/latest-2/bin:$PATH
fi




##W miscellaneous


bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


catmd () {
  pandoc $1 | lynx -stdin
}

pipewire_create_sink(){
  pactl load-module module-null-sink object.linger=1 media.class=Audio/Sink sink_name=my-combined-sink channel_map=stereo
}

# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

eval "$(pyenv init -)"
#
# Installation:
#
# Via shell config file  ~/.bashrc  (or ~/.zshrc)
#
#   Append the contents to config file
#   'source' the file in the config file
#
# You may also have a directory on your system that is configured
#    for completion files, such as:
#
#    /usr/local/etc/bash_completion.d/

###-begin-flutter-completion-###

if type complete &>/dev/null; then
  __flutter_completion() {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           flutter completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F __flutter_completion flutter
elif type compdef &>/dev/null; then
  __flutter_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 flutter completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef __flutter_completion flutter
elif type compctl &>/dev/null; then
  __flutter_completion() {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       flutter completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K __flutter_completion flutter
fi

###-end-flutter-completion-###

## Generated 2022-04-13 10:50:41.196535Z
## By /opt/flutter/bin/cache/flutter_tools.snapshot