{ config, lib, pkgs, ... }:
let
  cfg = config.clover.programs.telegram-tor;
in {
  options.clover.programs.telegram-tor = {
    enable = lib.mkEnableOption "Telegram with Tor launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.tor
      pkgs.telegram-desktop
      pkgs.netcat
      pkgs.jq
    ];

    home.file.".local/bin/telegram-tor" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        echo "Starting Tor on port 9050..."

        TOR_DIR="$(mktemp -d)"
        TORRC="$TOR_DIR/torrc"

        cleanup() {
          echo
          echo "Stopping Tor..."
          if [ -n "''${TOR_PID:-}" ]; then
            kill "$TOR_PID" 2>/dev/null || true
          fi
          rm -rf "$TOR_DIR"
        }

        trap cleanup EXIT INT TERM

        mkdir -p "$TOR_DIR/data"

        cat > "$TORRC" <<EOF
SocksPort 9050
DataDirectory $TOR_DIR/data
EOF

        ${pkgs.tor}/bin/tor -f "$TORRC" &
        TOR_PID=$!

        echo "Waiting for Tor to open SOCKS port..."
        until ${pkgs.netcat}/bin/nc -z 127.0.0.1 9050; do
          sleep 1
        done

        echo "Launching Telegram..."
        export ALL_PROXY="socks5://127.0.0.1:9050"

        CURRENT_WS="$(${pkgs.hyprland}/bin/hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq -r '.id')"

        nohup ${pkgs.telegram-desktop}/bin/Telegram >/dev/null 2>&1 &
        sleep 1
        ${pkgs.hyprland}/bin/hyprctl dispatch movetoworkspacesilent "$CURRENT_WS,class:^(org.telegram.desktop)$"

        echo "Telegram started."
        echo "This terminal is keeping Tor alive."
        echo "Press Ctrl+C here when you want to stop Tor."

        wait "$TOR_PID"
      '';
    };

    xdg.desktopEntries.telegram-tor = {
      name = "Telegram (Tor)";
      exec = "foot -T 'Telegram Tor Session' -a telegram-tor -e $HOME/.local/bin/telegram-tor";
      icon = "telegram";
      terminal = false;
      categories = [ "Network" "Chat" "InstantMessaging" ];
    };
  };
}
