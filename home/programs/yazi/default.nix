{
  description = "Yazi config flake"
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
};


  outputs = { self, nixpkgs, someLib, ... }: {
    packages.x86_64-linux = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in {
      yazi = pkgs.stdenv.mkDerivation {
        pname = "yazi";
        version = ".0";

        src = pkgs.fetchFromGitHub {
          owner = "yazi";
          repo = "cli";
          rev = "v1.0";
          sha256 = "some-sha256-hash";
        };

        buildInputs = [ pkgs.rustc pkgs.cargo someLib ];
        nativeBuildInputs = [ pkgs.cargo ];

        meta = with pkgs.lib; {
          description = "A CLI tool for managing YAML files";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      };
    };

    # Example of adding an app output if applicable
    apps.x86_64-linux.yazi = {
      type = "app";
      program = "${self.packages.x86_64-linux.yazi}/bin/yazi";
    };
  };
}
