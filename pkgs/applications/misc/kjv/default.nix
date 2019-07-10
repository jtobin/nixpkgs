{ stdenv, fetchFromGitHub, fetchpatch }:

stdenv.mkDerivation rec {
  pname = "kjv";
  version = "unstable-2018-12-25";

  src = fetchFromGitHub {
    owner = "bontibon";
    repo = pname;
    rev = "fda81a610e4be0e7c5cf242de655868762dda1d4";
    sha256 = "1favfcjvd3pzz1ywwv3pbbxdg7v37s8vplgsz8ag016xqf5ykqqf";
  };

  add-apocrypha = fetchpatch {
    url = "https://github.com/LukeSmithxyz/kjv/commit/b92b7622285d10464f9274f11e740bef90705bbc.patch";
    sha256 = "0n4sj8p9m10fcair4msc129jxkkx5whqzhjbr5k4lfgp6nb1zk8k";
  };

  patches = [ add-apocrypha ];

  makeFlags = [
    "PREFIX=${placeholder ''out''}"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp kjv $out/bin
  '';

  meta = with stdenv.lib; {
    description = "The Bible, King James Version";
    homepage = "https://github.com/bontibon/kjv";
    license = licenses.publicDomain;
    maintainers = [ maintainers.jtobin ];
  };
}

