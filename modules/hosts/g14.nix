{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.g14 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.modules.nixos.hyprlandBase
      self.modules.nixos.gamingBase
      self.modules.nixos.nvidiaBase

      inputs.home-manager.nixosModules.home-manager
      {
        nixpkgs.config.allowUnfree = true;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.warren = {pkgs, ...}: {
          # TODO: I shouldn't hardcode my username
          home.username = "warren";
          home.homeDirectory = "/home/warren";

          programs.direnv = {
            enable = true;
            enableBashIntegration = true;
            enableZshIntegration = true;
            enableFishIntegration = true;
            nix-direnv.enable = true; # Faster
          };

          programs.vscode = {
            enable = true;
            package = pkgs.vscode;
            mutableExtensionsDir = false;
            extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
              # Git
              eamodio.gitlens

              # Theme
              jdinhlife.gruvbox
              pkief.material-icon-theme

              # Rust
              rust-lang.rust-analyzer
              tamasfe.even-better-toml

              # Python
              ms-python.python
              ms-pyright.pyright
              ms-python.black-formatter

              # Nix
              jnoortheen.nix-ide

              # direnv for vscode. Mainly for nix shells
              mkhl.direnv

              # Lua
              sumneko.lua
            ];
            userSettings = {
              "workbench.colorTheme" = "Gruvbox Dark Medium";
              "telemetry.telemetryLevel" = "off";
              "python.languageServer" = "None";
              "editor.formatOnSave" = true;
              "nix.enableLanguageServer" = true;
              "nix.serverPath" = "nixd";
              "nix.serverSettings" = {
                "nixd" = {formatting = {command = ["nixpkgs-fmt"];};};
                # "nil" = {
                #   "diagnostics" = {
                #     "ignored" = [
                #       "unused_binding"
                #       "unused_with"
                #     ];
                #   };
                #   "formatting" = {
                #     "command" = [
                #       "nixpkgs-fmt"
                #     ];
                #   };
                # };
              };
              "workbench.startupEditor" = "none";
              "editor.fontLigatures" = true;
              "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
              "rust-analyzer.server.path" = "rust-analyzer";
            };
          };
          # Packages that should be installed to the user profile.
          home.packages = with pkgs; [
            vesktop
            nixd
            neofetch
            tmux

            # archives
            zip
            xz
            unzip
            p7zip

            # utils
            ripgrep # recursively searches directories for a regex pattern
            jq # A lightweight and flexible command-line JSON processor
            eza # A modern replacement for ‘ls’
            fzf # A command-line fuzzy finder
            mission-center # A nice task-manager like thing

            # modrinth-app # Modrinth app for minecraft
            # prismlauncher # Prism launcher for when modrinth is broken
            # zulu21 # java 21

            # Thermals and performance
            s-tui # stres test tui
            stress # stress testing

            # My minecraft package manager
            # mcmpmgr.packages.${system}.mcmpmgr

            # stremio
            polychromatic

            ## Games and launchers
            # heroic # Epic games
            # osu-lazer-bin

            # MTG things
            # cockatrice
            # forge-mtg
            # xmage

            # Godot
            # godot_4

            # Blender
            # blender

            # Pipewire easyeffects
            easyeffects

            # Reading
            # calibre

            # Torrenting
            # qbittorrent

            # Free Open Source YT client
            # freetube

            # Nexus mods app
            # nexusmods-app-unfree

            # Final Fantasy 14 Launcher
            # xivlauncher

            # Vintage story
            # pkgs-unfree.vintagestory
          ];

          gtk = {
            enable = true;
            # theme = {
            #   name = "Breeze-Dark";
            #   # package = pkgs.libsForQt5.breeze-gtk;
            # };
            # iconTheme = {
            #   name = "breeze-dark";
            #   # package = pkgs.libsForQt5.breeze-icons;
            # };
            # cursorTheme = {
            #   name = "breeze_cursors";
            #   # package = pkgs.libsForQt5.breeze-icons;
            # };
            gtk3 = {extraConfig.gtk-application-prefer-dark-theme = true;};
          };

          # home.pointerCursor = {
          #   gtk.enable = true;
          #   name = "breeze_cursors";
          #   package = pkgs.libsForQt5.breeze-icons;
          #   size = 16;
          # };

          dconf.settings = {
            "org/gnome/desktop/interface" = {
              gtk-theme = "Breeze-Dark";
              color-scheme = "prefer-dark";
            };
          };

          # Bluetooth applet
          # TODO: Re-enable when switching back to Hyprland
          # services.blueman-applet.enable = true;

          home.stateVersion = "23.11";
          programs.home-manager.enable = true;
        };
        home-manager.backupFileExtension = "backup";
        # home-manager.extraSpecialArgs = {
        #   inherit user;
        #   inherit mcmpmgr;
        #   inherit system;
        #   inherit inputs;
        #   inherit pkgs-unstable;
        #   inherit pkgs-unfree;
        # };
      }

      # Host specific config
      ({
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }: {
        networking.hostName = "rog-g14";

        imports = [(modulesPath + "/installer/scan/not-detected.nix")];

        hardware.nvidia = {
          # Nvidia prime
          prime = {
            # Make sure to use the correct Bus ID values for your system!
            # intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
            amdgpuBusId = "PCI:101:0:0";
          };
        };

        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "thunderbolt"
          "usbhid"
          "usb_storage"
          "sd_mod"
          "rtsx_pci_sdmmc"
        ];
        boot.initrd.kernelModules = [];

        # Use the xanmod kernel
        # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

        # Use the latest linux kernel
        # boot.kernelPackages = pkgs.linuxPackages_latest;
        boot.kernelPackages = let
          nixpkgs-unfree = inputs.nixpkgs-unfree.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in
          lib.mkForce nixpkgs-unfree.linuxKernel.packages.linux_xanmod_latest;

        boot.kernelModules = ["kvm-amd" "hid_nintendo"];
        boot.extraModulePackages = with config.boot.kernelPackages; [];
        boot.kernelParams = [
          # Disable amd pstate to stop stupid boosting my cpu temp through the roof
          # "initcall_blacklist=amd_pstate_init"
          # "amd_pstate.enable=0"

          # Set amd pstate to guided
          "amd_pstate=guided"

          # Make Wayland and nvidia play nicely
          "nvidia_drm.modeset=1"

          # (Maybe) make bluetooth reconnections work without needing to restart bluetooth service
          # "btusb.enable_autosuspend=n"
          # "usbcore.autosuspend=-1"
        ];

        environment.variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          KWIN_X11_REFRESH_RATE = 144000;
          KWIN_X11_NO_SYNC_TO_VBLANK = 1;
          KWIN_X11_FORCE_SOFTWARE_VSYNC = 1;
        };

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/dfe5cdc6-62b7-4ef0-aa0c-e38f4b4c6b24";
          fsType = "ext4";
        };

        # fileSystems."/games" = {
        #   device = "/dev/disk/by-uuid/5536ab49-58e5-4de0-b017-be95b1c440f3";
        #   fsType = "ext4";
        #   options = [ "defaults" "users" "exec" "nofail" ];
        # };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/40F1-396F";
          fsType = "vfat";
          options = ["fmask=0022" "dmask=0022"];
        };

        # Star citizen requirements
        boot.kernel.sysctl = {
          # "vm.max_map_count" = 16777216; # Already set in platformOptimisations
          "fs.file-max" = 524288;
        };
        # See RAM, ZRAM & Swap
        swapDevices = [
          {
            device = "/var/lib/swapfile";
            size = 8 * 1024; # 8 GB Swap
          }
        ];

        zramSwap = {
          enable = true;
          memoryMax = 16 * 1024 * 1024 * 1024; # 16 GB ZRAM
        };

        # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
        # (the default) this is the recommended approach. When using systemd-networkd it's
        # still possible to use this option, but it's recommended to use it in conjunction
        # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
        networking.useDHCP = lib.mkDefault true;
        # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode =
          lib.mkDefault config.hardware.enableRedistributableFirmware;
      })
    ];
  };
}
