#!/bin/bash
__exedir="$(readlink -f -- "$(dirname -- "$0")")"
__measuretmp=$(mktemp -d) || exit 1

git clone git@github.com:iopipe/measure.git "$__measuretmp"

__runtmp=$(mktemp -d) || exit 1
cp -R * $__runtmp/  # copy .circleci dir to $__runtmp
cp $__measuretmp/measure/data/sls-nodejs8.10.yml serverless.yml
cd $__runtmp
npm install "$__exedir/.."" # or whereever the iopipe-js dir is
# We want to call the runmeasure script but from inside the sls project for the baseline handler!
$__measuretmp/runmeasure.sh -l nodejs8.10 -h baseline.handler

rm -rf "$__measuretmp"
rm -rf "$__runtmp"