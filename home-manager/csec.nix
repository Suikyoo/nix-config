{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [ 
    cyberchef
    bvi
    xxd
    nmap
    wireshark
    ghidra
    steghide
    zsteg
    exiftool
    tesseract
    zbar
    gimp
    dig
    sleuthkit
    unzip
    (python3.withPackages (ps: with ps; [
                           requests
                           pwntools
                           numpy
    ]))

  ];
}
