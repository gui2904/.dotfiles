{ config, lib, pkgs, ... }:
let
  cfg = config.clover.programs.telegram-tor;
  homeDir = config.home.homeDirectory;
in {
  options.clover.programs.telegram-tor = {
    enable = lib.mkEnableOption "Telegram with Tor launcher";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.tor
      pkgs.telegram-desktop
      pkgs.netcat
      pkgs.foot
    ];

    home.file.".local/bin/telegram-tor" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        echo "Starting Tor on port 9050..."

        TOR_DIR="$(mktemp -d)"
        TORRC="$TOR_DIR/torrc"

        cleanup() {
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

        exec ${pkgs.telegram-desktop}/bin/Telegram
      '';
    };

    home.file.".local/bin/telegram-tor-launcher" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        exec ${pkgs.foot}/bin/foot -T "Telegram Tor Session" -a telegram-tor -e ${homeDir}/.local/bin/telegram-tor
      '';
    };

    xdg.desktopEntries.telegram-tor = {
      name = "Telegram (Tor)";
      exec = "${homeDir}/.local/bin/telegram-tor-launcher";
      icon = "telegram";
      terminal = false;
      categories = [ "Network" "Chat" "InstantMessaging" ];
    };
  };
}
