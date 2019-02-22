#!/bin/sh

rm -rf /tmp/$$
git clone . /tmp/$$

cp .circleci/baseline.js /tmp/$$/

cd /tmp/$$
ls
yarn --ignore-engines

git clone git@github.com:iopipe/measure.git
measure/runmeasure.sh -l nodejs8.10 -h baseline.handler

rm -rf /tmp/$$
