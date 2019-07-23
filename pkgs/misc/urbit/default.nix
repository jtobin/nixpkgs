{ stdenv, fetchurl }:

let

  pname = "urbit";

  version = "v0.9.2";

  urbit-darwin = fetchurl {
    url = "https://bootstrap.urbit.org/urbit-darwin-${version}.tgz";
    sha256 = "0ldkxnvhw0c9gjzkn419r4p0hlja0w760ikp4pj5r7k7c02cl539";
  };

  urbit-linux64 = fetchurl {
    url = "https://bootstrap.urbit.org/urbit-linux64-${version}.tgz";
    sha256 = "1k3lxxy6px1in9q6nmla3577nzxmrsn09sljxnmnc6cn9i5xnryq";
  };

  urbit = if stdenv.isDarwin then urbit-darwin else urbit-linux64;

in

  stdenv.mkDerivation rec {
    inherit pname version;

    src = urbit;

    unpackPhase = ''
      mkdir -p tmp
      tar xzf $src -C tmp
    '';

    sourceRoot = "tmp";

    installPhase = ''
      mkdir -p $out/bin

      cp urbit $out/bin
      cp urbit-worker $out/bin
      cp -r urbit-terminfo $out/bin
    '';

    meta = with stdenv.lib; {
      description = "A personal server operating function";
      homepage = https://urbit.org;
      license = licenses.mit;
      maintainers = [ maintainers.jtobin ];
      platforms = with platforms; linux ++ darwin;
      # should have lower priority than when built from scratch
      priority = 6;
    };
  }

