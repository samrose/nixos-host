{ pkgs }:

''
# Default config for sway
#
# Copy this to ~/.config/sway/config and edit it to your liking.
#
# Read `man 5 sway` for a complete reference.

### Variables
#
# Logo key. Use Mod1 for Alt.
set $mod Mod1

# Home row direction keys, like vim
set $left h
set $down j
set $up k
set $right l

# Your preferred terminal emulator
set $term alacritty

# Your preferred application launcher
# Note: it's recommended that you pass the final command to sway
set $wofi_path ${pkgs.wofi}/bin/wofi
set $menu swaymsg exec -- $wofi_path -S drun

### Output configuration
#
# Default wallpaper (more resolutions are available in @datadir@/backgrounds/sway/)
# output * bg @datadir@/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill
output * bg #000000 solid_color

#
# Example configuration:
#
#   output HDMI-A-1 resolution 1920x1080 position 1920,0
#
# You can get the names of your outputs by running: swaymsg -t get_outputs

### Idle configuration
exec swayidle -w \
         timeout 60 'swaylock -f -c 000000' \
         timeout 90 'swaymsg "output * dpms off"' \
              resume 'swaymsg "output * dpms on"' \
         before-sleep 'swaylock -f -c 000000' \
         lock 'swaylock -f -c 000000'
bindsym --release $mod+Shift+s exec "loginctl lock-session $XDG_SESSION_ID"

# Idle inhibitors
for_window [app_id="firefox"] inhibit_idle fullscreen

### Input configuration
# input "1:1AT_Translated_set_2_keyboard" {
input * {
    xkb_layout gb
    xkb_options caps:escape
    repeat_rate 35
    repeat_delay 200
}

input "2:7:SynPS/2_Synaptics_TouchPad" {
    dwt enabled
    tap enabled
    natural_scroll enabled
    middle_emulation enabled
}

### Key bindings
#
# Basics:
#
# Start a terminal
bindsym $mod+Return exec $term

# Kill focused window
bindsym $mod+Shift+q kill

# Start your launcher
bindsym $mod+d exec $menu

# Drag floating windows by holding down $mod and left mouse button.
# Resize them with right mouse button + $mod.
# Despite the name, also works for non-floating windows.
# Change normal to inverse to use left mouse button for resizing and right
# mouse button for dragging.
floating_modifier $mod normal

# Reload the configuration file
bindsym $mod+Shift+c reload

# Exit sway (logs you out of your Wayland session)
bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'
#
# Moving around:
#
# Move your focus around
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right

# Move the focused window with the same, but add Shift
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right

#
# Workspaces:
#
    # Switch to workspace
    bindsym $mod+1 workspace 1
    bindsym $mod+2 workspace 2
    bindsym $mod+3 workspace 3
    bindsym $mod+4 workspace 4
    bindsym $mod+5 workspace 5
    bindsym $mod+6 workspace 6
    bindsym $mod+7 workspace 7
    bindsym $mod+8 workspace 8
    bindsym $mod+9 workspace 9
    bindsym $mod+0 workspace 10
    # Move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace 1
    bindsym $mod+Shift+2 move container to workspace 2
    bindsym $mod+Shift+3 move container to workspace 3
    bindsym $mod+Shift+4 move container to workspace 4
    bindsym $mod+Shift+5 move container to workspace 5
    bindsym $mod+Shift+6 move container to workspace 6
    bindsym $mod+Shift+7 move container to workspace 7
    bindsym $mod+Shift+8 move container to workspace 8
    bindsym $mod+Shift+9 move container to workspace 9
    bindsym $mod+Shift+0 move container to workspace 10
    # Note: workspaces can have any name you want, not just numbers.
    # We just use 1-10 as the default.
#
# Layout stuff:
#
    # You can "split" the current object of your focus with
    # $mod+b or $mod+v, for horizontal and vertical splits
    # respectively.
    bindsym $mod+b splith
    bindsym $mod+v splitv

    # Switch the current container between different layout styles
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # Make the current focus fullscreen
    bindsym $mod+f fullscreen

    # Toggle the current focus between tiling and floating mode
    bindsym $mod+Shift+space floating toggle

    # Swap focus between the tiling area and the floating area
    bindsym $mod+space focus mode_toggle

    # Move focus to the parent container
    bindsym $mod+a focus parent
#
# Scratchpad:
#
    # Sway has a "scratchpad", which is a bag of holding for windows.
    # You can send windows there and get them back later.

    # Move the currently focused window to the scratchpad
    bindsym $mod+Shift+minus move scratchpad

    # Show the next scratchpad window or hide the focused scratchpad window.
    # If there are multiple scratchpad windows, this command cycles through them.
    bindsym $mod+minus scratchpad show
#
# Resizing containers:
#
bindsym $mod+r mode "resize"
mode "resize" {
    # left will shrink the containers width
    # right will grow the containers width
    # up will shrink the containers height
    # down will grow the containers height
    bindsym $left resize shrink width 10px
    bindsym $down resize grow height 10px
    bindsym $up resize shrink height 10px
    bindsym $right resize grow width 10px

    # Ditto, with arrow keys
    bindsym Left resize shrink width 10px
    bindsym Down resize grow height 10px
    bindsym Up resize shrink height 10px
    bindsym Right resize grow width 10px

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

# Extra keybinds
set $pactl ${pkgs.pulseaudioLight}/bin/pactl
bindsym XF86AudioMute exec $pactl set-sink-mute 0 toggle
bindsym XF86AudioLowerVolume exec $pactl set-sink-volume 0 -5%
bindsym XF86AudioRaiseVolume exec $pactl set-sink-volume 0 +5%
bindsym XF86AudioMicMute exec $pactl set-source-mute 0 toggle

set $playerctl ${pkgs.playerctl}/bin/playerctl
bindsym XF86AudioPlay exec $playerctl play-pause
bindsym XF86AudioPause exec $playerctl play-pause
bindsym XF86AudioNext exec $playerctl next
bindsym XF86AudioPrev exec $playerctl previous


# Styling
default_border none

# Startup
# exec waybar
exec systemctl --user import-environment SWAYSOCK
exec swaymsg "workspace 9; exec $term --working-directory /etc/nixos -e sh -c 'while true; do vim .; done'; workspace 1"
exec swaymsg "workspace 10; exec spotify; workspace 1"
exec systemctl --user restart waybar
''
