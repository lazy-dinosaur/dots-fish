# Prompt function definition
function fish_prompt -d "Write out the prompt"
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

# Only run these commands in interactive sessions
if status is-interactive
    # Clear any existing greeting
    set -g fish_greeting ""

    # and not set -q TMUX
    # tmux ls | grep -v attached && tmux attach || tmux
    # tmux new-session -A -s mysession
end

# Initialize external tools
if type -q fish_ssh_agent
    fish_ssh_agent
end

# Initialize Starship and Zoxide
if type -q starship
    starship init fish | source
end

if type -q zoxide
    zoxide init fish | source
end

# Define and export environment variables
# Ensure no duplicate entries in PATH
set -gx EDITOR nvim

set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0

set -Ux FZF_DEFAULT_OPTS "\
--color=spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Define paths and ensure no duplicates
set -gx PATH $HOME/.bun/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx ANDROID_HOME "$HOME/Android/Sdk"
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $HOME/.npm-packages/bin $PATH
set -gx CGO_ENABLED 1

# Define other environment variables
set -gx EZA_STANDARD_OPTIONS --icons --hyperlink
set -gx OPENCV_LOG_LEVEL ERROR
set -gx JAVA_HOME '/usr/lib/jvm/java-21-openjdk-21.0.5.0.11-1.fc40.x86_64'
set -gx CLASSPATH $JAVA_HOME/lib
set -gx SDKMAN_DIR $HOME/.sdkman
set -gx XCURSOR_SIZE 24

set -Ux fish_tmux_config $HOME/.config/tmux/tmux.conf
set -Ux fish_tmux_autostart false
set -Ux fish_tmux_autoconnect true
set -Ux fish_tmux_default_session_name base

source ~/.config/fish/apikeys.fish

# Optionally set QT_QPA_PLATFORM_PLUGIN_PATH if needed
# set -gx QT_QPA_PLATFORM_PLUGIN_PATH /usr/lib64/qt5/plugins

alias ts='tmux new-session -A -s'
alias tn='tmux new'
alias tk='tmux kill-ses -t'
alias tka='tmux kill-session -a'
alias tko="tmux kill-session -a -t"
alias tl="tmux ls"
alias tal="tmux a"
alias ta="tmux a -t"
alias td="tmux detach"
#
function tz --wraps tmux --description 'tmux new session to target directory'
    z $argv && tmux new-session -A -s $argv
end

# alias obsidian='flatpak run md.obsidian.Obsidian --ozone-platform-hint=wayland --enable-wayland-ime --wayland-text-input-version=3'
