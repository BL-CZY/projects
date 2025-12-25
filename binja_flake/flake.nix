{
    description = "Binary Ninja Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }: 
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
        in {
           devShells.${system}.default = (pkgs.buildFHSEnv {
               name = "binary-ninja-env";

               targetPkgs = pkgs: with pkgs; [
                    glibc
                    stdenv.cc.cc.lib # libstdc++.so.6
                    zlib # libz.so.1
                    libglvnd # libEGL.so.1 & libOpenGL.so.0
                    fontconfig # libfontconfig.so.1
                    libx11 # libX11.so.6
                    libxkbcommon # libxkbcommon.so.0
                    libGLX # libGLX.so.0
                    freetype # libfreetype.so.6
                    dbus # libdbus
                    
                    # QT Dependencies
                    xorg.libxcb
                    xorg.xcbutilcursor
                    xorg.xcbutilrenderutil
                    xorg.xcbutil
                    xorg.xcbutilimage
                    xorg.xcbutilkeysyms
                    qt6.qtwayland

                    # Wayland
                    egl-wayland
               ];
               runScript = "zsh";
               }).env; 
        };
}
