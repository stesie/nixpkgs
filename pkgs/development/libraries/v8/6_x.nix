{ stdenv, lib, fetchgit, fetchFromGitHub, gn, ninja, python, glib, pkgconfig
, doCheck ? false
, snapshot ? true
}:

let
  arch = if stdenv.isAarch32
         then if stdenv.is64bit
              then"arm64"
              else "arm"
         else if stdenv.is64bit
              then"x64"
              else "ia32";
  git_url = "https://chromium.googlesource.com";

  deps = {
    "base/trace_event/common" = fetchgit {
      url = "${git_url}/chromium/src/base/trace_event/common.git";
      rev = "211b3ed9d0481b4caddbee1322321b86a483ca1f";
      sha256 = "080sya1dg32hi5gj7zr3r5l18r6w8g0imajyf3xfvnz67a2i8dd7";
    };
    "build" = fetchgit {
      url = "${git_url}/chromium/src/build.git";
      rev = "7315579e388589b62236ad933f09afd1e838d234";
      sha256 = "14gsigyjfm03kfzmz0v6429b6qnycvzx0yj3vwaks8may26aiv71";
    };
    "buildtools" = fetchgit {
      url = "${git_url}/chromium/buildtools.git";
      rev = "0dd5c6f980d22be96b728155249df2da355989d9";
      sha256 = "0m1fh0qjcx9c69khnqcsqvrnqs7ji6wfxns9vv9mknj20sph5ydr";
    };
    "buildtools/clang_format/script" = fetchgit {
      url = "${git_url}/chromium/llvm-project/cfe/tools/clang-format.git";
      rev = "0653eee0c81ea04715c635dd0885e8096ff6ba6d";
      sha256 = "1m3h5kln4v2hcwc4ahzk356415iizcg8cmika8221qvqci4wj7bm";
    };
    "buildtools/third_party/libc++/trunk" = fetchgit {
      url = "${git_url}/chromium/llvm-project/libcxx.git";
      rev = "85a7702b4cc5d69402791fe685f151cf3076be71";
      sha256 = "0jphn7iacdigk7y7fccgz7a9a27rpmwihgzyc0bwwf2izix9fbks";
    };
    "buildtools/third_party/libc++abi/trunk" = fetchgit {
      url = "${git_url}/chromium/llvm-project/libcxxabi.git";
      rev = "05a73941f3fb177c4a891d4ff2a4ed5785e3b80c";
      sha256 = "1npzybqgcglz3hdfn12bqfr46kxcx9sz27xdvzqp10p11jpkzz5c";
    };
    "buildtools/third_party/libunwind/trunk" = fetchgit {
      url = "${git_url}/external/llvm.org/libunwind.git";
      rev = "1e1c6b739595098ba5c466bfe9d58b993e646b48";
      sha256 = "12wpvxchi0nik2xh06j3ivkf9mzg5nmpn87w3cb6dm9lcfh8mv5i";
    };
    "test/benchmarks/data" = fetchgit {
      url = "${git_url}/v8/deps/third_party/benchmarks.git";
      rev = "05d7188267b4560491ff9155c5ee13e207ecd65f";
      sha256 = "0ad2ay14bn67d61ks4dmzadfnhkj9bw28r4yjdjjyzck7qbnzchl";
    };
    "test/mozilla/data" = fetchgit {
      url = "${git_url}/v8/deps/third_party/mozilla-tests.git";
      rev = "f6c578a10ea707b1a8ab0b88943fe5115ce2b9be";
      sha256 = "0rfdan76yfawqxbwwb35aa57b723j3z9fx5a2w16nls02yk2kqyn";
    };
    "test/test262/data" = fetchgit {
      url = "${git_url}/external/github.com/tc39/test262.git";
      rev = "a6c1d05ac4fed084fa047e4c52ab2a8c9c2a8aef";
      sha256 = "1cy3val2ih6r4sbaxd1v9fir87mrlw1kr54s64g68gnch53ck9s3";
    };
    "test/test262/harness" = fetchgit {
      url = "${git_url}/external/github.com/test262-utils/test262-harness-py.git";
      rev = "0f2acdd882c84cff43b9d60df7574a1901e2cdcd";
      sha256 = "00brj5avp43yamc92kinba2mg3a2x1rcd7wnm7z093l73idprvkp";
    };
    "test/wasm-js" = fetchgit {
      url = "${git_url}/external/github.com/WebAssembly/spec.git";
      rev = "2113ea7e106f8a964e0445ba38f289d2aa845edd";
      sha256 = "1c32mqgbq8afwwaazjhzjd0dpwd4k0vsibvhijmph89yvaydd8bq";
    };
    "third_party/googletest/src" = fetchgit {
      url = "${git_url}/external/github.com/google/googletest.git";
      rev = "ce468a17c434e4e79724396ee1b51d86bfc8a88b";
      sha256 = "0nik8wb1b0zk2sslawgp5h211r5bc4x7m962dgnmbk11ccvsmr23";
    };
    "third_party/icu" = fetchgit {
      url = "${git_url}/chromium/deps/icu.git";
      rev = "a9a2bd3ee4f1d313651c5272252aaf2a3e7ed529";
      sha256 = "1bfyxakgv9z0rxbqsy5csi85kg8dqy7i6zybmng5wyzag9cns4f9";
    };
    "third_party/instrumented_libraries" = fetchgit {
      url = "${git_url}/chromium/src/third_party/instrumented_libraries.git";
      rev = "323cf32193caecbf074d1a0cb5b02b905f163e0f";
      sha256 = "0q3n3ivqva28qpn67ds635521pwzpc9apcyagz65i9j17bb1k231";
    };
    # templates of code generator require jinja2 2.8 (while nixpkgs has 2.9.5, which breaks the template)
    "third_party/jinja2" = fetchgit {
      url = "${git_url}/chromium/src/third_party/jinja2.git";
      rev = "b41863e42637544c2941b574c7877d3e1f663e25";
      sha256 = "1qgilclkav67m6cl2xq2kmzkswrkrb2axc2z8mw58fnch4j1jf1r";
    };
    "third_party/markupsafe" = fetchgit {
      url = "${git_url}/chromium/src/third_party/markupsafe.git";
      rev = "8f45f5cfa0009d2a70589bcda0349b8cb2b72783";
      sha256 = "168ppjmicfdh4i1l0l25s86mdbrz9fgxmiq1rx33x79mph41scfz";
    };
    "tools/clang" = fetchgit {
      url = "${git_url}/chromium/src/tools/clang.git";
      rev = "c0b1d892b2bc1291eb287d716ca239c1b03fb215";
      sha256 = "1mz1pqzr2b37mymbkqkmpmj48j7a8ig0ibaw3dfilbx5nbl4wd2z";
    };
  };

in

stdenv.mkDerivation rec {
  name = "v8-${version}";
  version = "6.9.427.18";

  inherit doCheck;

  src = fetchFromGitHub {
    owner = "v8";
    repo = "v8";
    rev = version;
    sha256 = "0qm4rd6ln9lp0bchrq95mlhxa2nshmc50znx2rlrcmcw9pjzjkws";
  };

  postUnpack = ''
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (n: v: ''
        target="$sourceRoot/${n}"
        test -x "''${target%/*}" && chmod +w "''${target%/*}"
        mkdir -p "$target"
        cp -r ${v}/* "$target"
      '') deps)}
  '';

  prePatch = ''
    # use our gn, not the bundled one
    sed -i -e 's#gn_path = .*#gn_path = "${gn}/bin/gn"#' tools/mb/mb.py

    # disable tests
    if [ "$doCheck" = "" ]; then sed -i -e '/"test:gn_all",/d' BUILD.gn; fi

    # disable sysroot usage
    chmod u+w build/config build/config/sysroot.gni
    sed -i build/config/sysroot.gni \
        -e '/use_sysroot =/ { s#\(use_sysroot =\).*#\1 false#; :a  n; /current_cpu/ { s/^/#/; ba };  }'

    # patch shebangs (/usr/bin/env)
    patchShebangs tools/dev/v8gen.py
  '';

  configurePhase = ''
    tools/dev/v8gen.py -vv ${arch}.release -- \
        is_component_build=true \
        ${if snapshot then "v8_use_external_startup_data=false" else "v8_use_snapshot=false" } \
        is_clang=false \
        linux_use_bundled_binutils=false \
        treat_warnings_as_errors=false
  '';

  nativeBuildInputs = [ gn ninja pkgconfig ];
  buildInputs = [ python glib ];

  buildPhase = ''
    ninja -C out.gn/${arch}.release/
  '';

  enableParallelBuilding = true;

  installPhase = ''
    install -vD out.gn/${arch}.release/d8 "$out/bin/d8"
    install -vD out.gn/${arch}.release/mksnapshot "$out/bin/mksnapshot"
    mkdir -p "$out/lib"
    for f in libc++.so libicui18n.so libicuuc.so libv8_libbase.so libv8_libplatform.so libv8.so; do
        install -vD out.gn/${arch}.release/$f "$out/lib/$f"
    done
    install -vD out.gn/${arch}.release/icudtl.dat "$out/lib/icudtl.dat"
    mkdir -p "$out/include"
    cp -vr include/*.h "$out/include"
    cp -vr include/libplatform "$out/include"
  '';

  meta = with lib; {
    description = "Google's open source JavaScript engine";
    maintainers = with maintainers; [ cstrahan proglodyte ];
    platforms = platforms.linux;
    license = licenses.bsd3;
  };
}
