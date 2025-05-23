{
  description = "slstatus";

  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      configFile = import ./config.nix { inherit pkgs; };
    in
    {
      defaultPackage.${system} =
        with pkgs;
        stdenv.mkDerivation {
          name = "slstatus";
          version = "1.0";

          src = self;

          nativeBuildInputs = [ pkg-config ];
          buildInputs = [
            xorg.libX11
            xorg.libXau
            xorg.libXdmcp
          ];

          installFlags = [ "PREFIX=$(out)" ];

          prePatch = ''
            cp ${configFile} config.def.h
          '';

          meta = {
            mainProgram = "slstatus";
          };
        };
    };
}
