#!/bin/sh

__exedir="$(readlink -f -- "$(dirname -- "$0")")"

rm -rf /tmp/$$
git clone "$__exedir/.." /tmp/$$

cp "$__exedir/baseline.js" /tmp/$$/

cd /tmp/$$
ls
yarn --ignore-engines

git clone git@github.com:iopipe/measure.git
ls -al
measure/runmeasure.sh -l nodejs8.10 -h baseline.handler
ls -al

rm -rf /tmp/$$
