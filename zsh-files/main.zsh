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
