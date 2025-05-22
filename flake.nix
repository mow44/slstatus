{
  description = "slstatus";

  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    {
      defaultPackage.x86_64-linux =
        with import nixpkgs { system = "x86_64-linux"; };
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

          meta = {
            mainProgram = "slstatus";
          };
        };
    };
}
