#!/bin/bash -eu

STACK="stack --stack-yaml stack-ghcjs.yaml"

$STACK install
$STACK exec -- ghcjs --make Setup.hs
$STACK exec --no-ghc-package-path -- node Setup.jsexe/all.js clean
$STACK exec --no-ghc-package-path -- node Setup.jsexe/all.js configure \
       --prefix=$($STACK path --ghc-paths)/$(basename $($STACK path --local-install-root)) \
       --package-db=$($STACK path --global-pkg-db) \
       --ghcjs
$STACK exec --no-ghc-package-path -- node Setup.jsexe/all.js build
$STACK exec --no-ghc-package-path -- node Setup.jsexe/all.js install
