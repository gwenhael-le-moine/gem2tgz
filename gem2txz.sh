#!/bin/sh
# Copyright © 2009-2010 by Cycojesus

GEM=$1

GEMSROOT=$(gem environment gemdir)

TMP=/tmp
PKG=$TMP/packagingagem

rm -fr $PKG

mkdir -p $PKG$GEMSROOT

gem install $GEM \
    --install-dir $PKG$GEMSROOT \
    --bindir $PKG/usr/bin \
    --force \
    --ignore-dependencies

cd $PKG

ARCH=noarch
BUILD=1cyco

NAME=$(grep "s\.name = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}')
VERSION=$(grep "s\.version = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "\".*\"" | tr -d '"')

mkdir -p $PKG/install
cat <<EOF > $PKG/install/slack-desc
$NAME: $NAME ($(grep "s\.summary = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}'))
$NAME:
$NAME: $(grep "s\.description = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}')
$NAME:
$NAME:
$NAME:
$NAME:
$NAME:
$NAME:
$NAME: $(grep "s\.homepage = " $PKG$GEMSROOT/specifications/*.gemspec | grep -o "%q{.*}" | sed 's|%q{||' | tr -d '}')
$NAME:
EOF

makepkg --linkadd y --chown n $TMP/rubygem-$NAME-$VERSION-$ARCH-$BUILD.txz
