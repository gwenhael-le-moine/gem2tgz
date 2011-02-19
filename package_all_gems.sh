#!/bin/sh -x
# Copyright (C) 2009 by Cycojesus

GEMSLIST=$(gem list --no-version | grep -v -e "^\*")
NB_GEMS=$(echo $GEMSLIST | wc -w)
i=0

echo "We have $NB_GEMS gems to pack"

for GEM in $GEMSLIST ; do
    i=$(expr $i + 1)
    echo "$i/$NB_GEMS : Processing $GEM"
    gem2txz $GEM
done
