#!/bin/bash
__gitdir=$(dirname -- $(dirname -- "$0"))
__measuretmp=$(mktemp -d) || exit 1
MEASURE_REPO=${MEASURE_REPO:-git@github.com:iopipe/measure.git}
git clone "$MEASURE_REPO" "$__measuretmp"

__runtmp=$(mktemp -d) || exit 1
cp -R $__gitdir/.circleci/* $__runtmp/  # copy .circleci dir to $__runtmp
cd $__runtmp
npm install "$__exedir/.." # or whereever the iopipe-js dir is
# We want to call the runmeasure script but from inside the sls project for the baseline handler!
cp $__measuretmp/measure/data/sls-nodejs8.10.yml serverless.yml
$__measuretmp/runmeasure.sh -l nodejs8.10 -h baseline.handler

rm -rf "$__measuretmp"
rm -rf "$__runtmp"