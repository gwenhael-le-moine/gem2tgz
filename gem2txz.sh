#!/bin/sh
# Copyright © 2009-2011 by Cycojesus

GEM=${GEM:-$1}

ARCH=${ARCH:-noarch}
BUILD=${BUILD:-1}
PACKAGER=${PACKAGER:-cyco}
OUTPUT=${OUTPUT:-/tmp}
TMP=${TMP:-/tmp/$PACKAGER}
PKG=${PKG:-$TMP/pkg-rubygem-$GEM}

GEMSROOT=${GEMSROOT:-$(gem environment gemdir)}

rm -fr $PKG

mkdir -p $PKG$GEMSROOT

gem install $GEM \
    --install-dir $PKG$GEMSROOT \
    --bindir $PKG/usr/bin \
    --force \
    --ignore-dependencies

cd $PKG

PRGNAM=rubygem-$(grep "s\.name = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}')
VERSION=$(grep "s\.version = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "\".*\"" | tr -d '"')

mkdir -p $PKG/install
cat <<EOF > $PKG/install/slack-desc
$PRGNAM: $PRGNAM ($(grep "s\.summary = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}'))
$PRGNAM:
$PRGNAM: $(grep "s\.description = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}')
$PRGNAM:
$PRGNAM:
$PRGNAM:
$PRGNAM:
$PRGNAM:
$PRGNAM:
$PRGNAM: $(grep "s\.homepage = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}')
$PRGNAM:
EOF

makepkg --linkadd y --chown n $OUTPUT/$PRGNAM-$VERSION-$ARCH-$BUILD$PACKAGER.txz
