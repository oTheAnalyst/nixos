# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  #gpu configurations for gaming 
  hardware.graphics = {
    enable = true;
   #driSupport = true;
    enable32Bit = true;
  };
  
  services.xserver.videoDrivers = ["amdgpu"];

  # Install and enable Steam 
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  #end of gpu configs

#hyprland install 
programs.hyprland = {
    enable = true;
    xwayland.enable = true;
};

  #nix flakes experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking settings
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Enable networking
  };

  # Set your time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

 #bluetooth enable
 hardware.bluetooth.enable = true;
 hardware.bluetooth.powerOnBoot = true;

  # Enable the X11 windowing system
  services.xserver = {
    enable = true;
    # Enable the displayManager
    displayManager.sddm.enable = true;
    # Enable the Desktop Environment
    desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # Uncomment if you want to use JACK applications
    # jack.enable = true;
  };


  # Define a user account
  users.users.pretender = {
    isNormalUser = true;
    description = "pretender";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Add user-specific packages here if needed
    ];
  };

  # Install Firefox
  programs.firefox.enable = true;

 #  home-manager = {
 #    extraSpecialArg = {inherit inputs; };
 #    users = {
 #        "pretender" = import ./home.nix;
 #    };
 #  };
        
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    mangohud
    obsidian
    obs-studio
    starship
    lolcat
    pfetch
    ani-cli
    vesktop
    cool-retro-term
    protonup
    vesktop
    neovim 
    gnumake #depedency for r.nvim 
    libgcc #depedency for r.nvim
    gccgo #depedency for r.nvim
    wget
    btop
    wine
    piper
    zoom
    libratbag
    kitty
    signal-desktop
    mangareader
    sqlite
    nerdfonts
    R
    emacs
    hyfetch
    xclip 
    qpwgraph
    freetube
    thunderbird
    alacritty
    teamspeak_client
    git
    input-remapper
    home-manager
    yazi
    qbittorrent
    blueman
    protonmail-desktop
    bitwarden-desktop
    rofi # hyprland
    waybar # hyprland plugin
    swww # hyprland plugin
    mako #hyprland plugin
  ];

  # Environment session variables
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOL_PATHS = "/home/pretender/.steam/root/compatibilitytools.d";
  };
  #fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
   ];
  
  #enable open RGB
  services.hardware.openrgb.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
