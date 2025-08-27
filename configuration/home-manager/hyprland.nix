{ pkgs, version, lib, nix-index-database, inputs, ... }@ args:
let
  appmod = "CTRLALT";
in
{
  xdg.portal.enable = true;
  services.libinput.enable = true;
  programs.uwsm.enable = true;
  services.seatd.enable = true;
  programs.xwayland.enable = true;
  services.udev.enable = true;
  services.xserver.enable = false;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  home-manager.users.user = {
    xdg.configFile = {
      "hypr/hyprpaper.conf" = {
        text = import ./hyprland/hyprpaper.nix { };
      };
      "hypr/hyprlock.conf" = {
        text = import ./hyprland/hyprlock.nix { };
      };
      "hypr/hypridle.conf" = {
        text = import ./hyprland/hypridle.nix { inherit pkgs; };
      };
      "tofi/config" = {
        text = import ./hyprland/tofi.nix args;
      };
      "waybar/config.jsonc" = {
        text = import ./hyprland/waybar.nix args;
      };
      "waybar/style.css" = {
        source = ./hyprland/waybar/style.css;
      };
    };
    wayland.windowManager = {
      hyprland = {
        enable = true;
        systemd.enable = true;
        settings = {
          bind = [
            "${appmod}, S, exec, ${pkgs.grimblast}/bin/grimblast copy area"
            "SUPER_SHIFT, S, exec, ${pkgs.grimblast}/bin/grimblast copy area"
            "SUPER, L, exec, pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock"
            "SUPER_SHIFT, L, exit"
            "${appmod}, F, exec, firefox-devedition"
            "${appmod}, W, exec, pkill .waybar-wrapped; ${pkgs.waybar}/bin/waybar"
            "${appmod}, T, exec, ${import ./shell/kitty/kitty.pkg.nix { inherit pkgs inputs; }}/bin/kitty"
            "${appmod}, D, exec, ${pkgs.kitty}/bin/kitty"
            "${appmod}, O, exec, obsidian"
            "${appmod}, J, exec, jellyfinmediaplayer"
            "${appmod}, E, exec, nautilus"
            "SUPER, E, exec, nautilus"
            "ALT, Tab, cyclenext"
            "ALT_SHIFT, Tab, cyclenext, prev"
            "SUPER, Tab, changegroupactive, f"
            "SUPER_SHIFT, Tab, changegroupactive, b"
            "ALT, Tab, bringactivetotop"
            "ALT, Space, exec, ${pkgs.tofi}/bin/tofi-drun --drun-launch=true"
            "SUPER, Space, exec, ${pkgs.toybox}/bin/killall -SIGUSR1 waybar"
            "SUPER, F1, exec, sh ${./hyprland/workspace2d.sh} right"
            "SUPER, right, exec, sh ${./hyprland/workspace2d.sh} right"
            "SUPER_CTRL, F1, exec, sh ${./hyprland/workspace2d.sh} right all"
            "SUPER_CTRL, right, exec, sh ${./hyprland/workspace2d.sh} right all"
            "SUPER_ALT, F1, exec, sh ${./hyprland/workspace2d.sh} move_right"
            "SUPER_ALT, right, exec, sh ${./hyprland/workspace2d.sh} move_right"
            "SUPER_ALT_CTRL, F1, exec, sh ${./hyprland/workspace2d.sh} move_right all"
            "SUPER_ALT_CTRL, right, exec, sh ${./hyprland/workspace2d.sh} move_right all"
            "SUPER, F2, exec, sh ${./hyprland/workspace2d.sh} left"
            "SUPER, left, exec, sh ${./hyprland/workspace2d.sh} left"
            "SUPER_CTRL, F2, exec, sh ${./hyprland/workspace2d.sh} left all"
            "SUPER_CTRL, left, exec, sh ${./hyprland/workspace2d.sh} left all"
            "SUPER_ALT, F2, exec, sh ${./hyprland/workspace2d.sh} move_left"
            "SUPER_ALT, left, exec, sh ${./hyprland/workspace2d.sh} move_left"
            "SUPER_ALT_CTRL, F2, exec, sh ${./hyprland/workspace2d.sh} move_left all"
            "SUPER_ALT_CTRL, left, exec, sh ${./hyprland/workspace2d.sh} move_left all"
            "SUPER_SHIFT, F1, exec, sh ${./hyprland/workspace2d.sh} up"
            "SUPER, up, exec, sh ${./hyprland/workspace2d.sh} up"
            "SUPER_SHIFT_CTRL, F1, exec, sh ${./hyprland/workspace2d.sh} up all"
            "SUPER_CTRL, up, exec, sh ${./hyprland/workspace2d.sh} up all"
            "SUPER_SHIFT_ALT, F1, exec, sh ${./hyprland/workspace2d.sh} move_up"
            "SUPER_ALT, up, exec, sh ${./hyprland/workspace2d.sh} move_up"
            "SUPER_SHIFT_ALT_CTRL, F1, exec, sh ${./hyprland/workspace2d.sh} move_up all"
            "SUPER_ALT_CTRL, up, exec, sh ${./hyprland/workspace2d.sh} move_up all"
            "SUPER_SHIFT, F2, exec, sh ${./hyprland/workspace2d.sh} down"
            "SUPER, down, exec, sh ${./hyprland/workspace2d.sh} down"
            "SUPER_SHIFT_CTRL, F2, exec, sh ${./hyprland/workspace2d.sh} down all"
            "SUPER_CTRL, down, exec, sh ${./hyprland/workspace2d.sh} down all"
            "SUPER_SHIFT_ALT, F2, exec, sh ${./hyprland/workspace2d.sh} move_down"
            "SUPER_ALT, down, exec, sh ${./hyprland/workspace2d.sh} move_down"
            "SUPER_SHIFT_ALT_CTRL, F2, exec, sh ${./hyprland/workspace2d.sh} move_down all"
            "SUPER_ALT_CTRL, down, exec, sh ${./hyprland/workspace2d.sh} move_down all"
            "SUPER, V, exec, ${pkgs.cliphist}/bin/cliphist list | ${pkgs.tofi}/bin/tofi | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"
            "SUPER_CTRL, V, exec, ${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.imagemagick}/bin/display"
            "SUPER, F, togglefloating"
            "SUPER, G, togglegroup"
            "SUPER_SHIFT, G, moveoutofgroup"
            "ALT, F4, killactive"
            "CTRL_ALT_SHIFT, right, pin"
            "SUPER, bracketright, fullscreen, 1"
            ", XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "SHIFT, XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ];
          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:274, resizewindow"
          ];
          binde = [
            ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-"
            ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"
          ];
          env = [];
          # monitor = [
          #   ", 1920x1080@60, auto, 1"
          # ];
          exec-once = [
            "${pkgs.kitty}/bin/kitty"
            "${pkgs.dunst}/bin/dunst"
            "${pkgs.hyprpaper}/bin/hyprpaper"
            "${pkgs.waybar}/bin/waybar"
            "${pkgs.hypridle}/bin/hypridle"
            "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
            "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
          ];
          windowrulev2 = [
            "float,class:^(kitty)$"
            "float,class:^(pavucontrol)$"
            "float,class:^(org\.gnome\.nautilus)$"
          ];
          layerrule = [
            "blur,launcher"
            "blur,waybar"
            "ignorealpha [0.05],waybar"
          ];
          workspace = [
            "w[tg1],rounding:false"
            "w[t1],rounding:false"
          ];
          general = {
            border_size = 0;
            gaps_in = 3;
            gaps_out = 0;
            gaps_workspaces = 3;
            "col.inactive_border" = "0x33ffffff";
            "col.active_border" = "0x44ffffff";
            "col.nogroup_border" = "0x44dd7777";
            "col.nogroup_border_active" = "0x55dd7777";
            layout = "dwindle";
            no_focus_fallback = false;
            resize_on_border = true;
            extend_border_grab_area = 15;
            hover_icon_on_border = true;
            allow_tearing = false;
          };
          cursor = {
            inactive_timeout = 10;
            no_warps = true;
          };
          binds = {
            movefocus_cycles_fullscreen = false;
          };
          decoration = {
            rounding = 8;
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            fullscreen_opacity = 1.0;
            dim_inactive = true;
            dim_strength = 0.1;
            dim_special = 0.1;
            dim_around = 0.4;
            shadow = {
              enabled = true;
              range = 5;
              render_power = 3;
              ignore_window = true;
              color = "0xee1a1a1a";
              color_inactive = "0xee1a1a1a";
              offset = "0 0";
              scale = 1.0;
            };
            blur = {
              enabled = true;
              size = 5;
              passes = 5;
              ignore_opacity = false;
              xray = false;
              noise = 0.00;
              contrast = 0.9;
              brightness = 0.8;
              vibrancy = 0.1;
              vibrancy_darkness = 0.0;
              special = true;
              popups = true;
              popups_ignorealpha = 0.2;
            };
          };
          animations = {
            enabled = true;
            first_launch_animation = true;
          };
          animation = [
            "workspaces,1,1,default"
            "windows,1,1,default"
          ];
          input = {
            kb_layout = "us";
            kb_options = "compose:ralt";
            numlock_by_default = false;
            repeat_rate = 25;
            repeat_delay = 500;
            sensitivity = 1.0;
            accel_profile = "flat";
            force_no_accel = false;
            left_handed = false;
            scroll_button = 273;
            scroll_button_lock = false;
            natural_scroll = false;
            follow_mouse = 2;
            mouse_refocus = true;
            float_switch_override_focus = 1;
            special_fallthrough = false;
            touchpad = {
              disable_while_typing = true;
              natural_scroll = true;
              scroll_factor = 1.0;
              middle_button_emulation = true;
              tap_button_map = "lrm";
              clickfinger_behavior = true;
              tap-to-click = true;
              drag_lock = true;
              tap-and-drag = false;
            };
            touchdevice = {
              transform = 0;
            };
            tablet = {
              transform = 0;
              region_position = "0 0";
              region_size = "0 0";
              relative_input = false;
              output = "DP-1";
            };
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
            workspace_swipe_distance = 300;
            workspace_swipe_invert = true;
            workspace_swipe_min_speed_to_force = 30;
            workspace_swipe_cancel_ratio = 0.5;
            workspace_swipe_create_new = false;
            workspace_swipe_direction_lock = true;
            workspace_swipe_direction_lock_threshold = 20;
            workspace_swipe_forever = true;
          };
          group = {
            insert_after_current = true;
            focus_removed_window = true;
            "col.border_active" = "0x44ffffff";
            "col.border_inactive" = "0x33ffffff";
            "col.border_locked_active" = "0x66ffffff";
            "col.border_locked_inactive" = "0x55ffffff";
            groupbar = {
              enabled = true;
              font_family = "monospace";
              height = 14;
                "col.active" = "0x44ffffff";
                "col.inactive" = "0x33ffffff";
                "col.locked_active" = "0x66ffffff";
                "col.locked_inactive" = "0x55ffffff";
            };
          };
          misc = {
            disable_hyprland_logo = true;
            focus_on_activate = true;
          };
          debug = {
            enable_stdout_logs = true;
          };
        };
        xwayland.enable = true;
      };
    };
  };
}
