{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, oniguruma
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "yazi";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "sxyazi";
    repo = "yazi";
    rev = "v${version}";
    hash = "sha256-vK8P+6hn7NiympkQE8Bp45ZPqTO24VTSu0QwnXHfdXw=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "notify-6.1.1" = "sha256-5Ft2yvRPi2EaErcGBkF/3Xv6K7ijFGbdjmSqI4go/h4=";
    };
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    oniguruma
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.Foundation
  ];

  env = {
    RUSTONIG_SYSTEM_LIBONIG = true;
  };

  meta = with lib; {
    description = "Blazing fast terminal file manager written in Rust, based on async I/O";
    homepage = "https://github.com/sxyazi/yazi";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "yazi";
  };
}
