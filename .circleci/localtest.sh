#!/bin/bash -e -x
MEASURE_BRANCH=${MEASURE_BRANCH:-master}
MEASURE_REPO=${MEASURE_REPO:-git@github.com:iopipe/measure.git}

measure() {
    cp -R $__gitdir/.circleci/* $__runtmp/
    pushd $__runtmp
        pushd $__gitdir
            npm install 2>/dev/null >/dev/null
            npm run build 2>/dev/null >/dev/null
            release_file=$(npm pack 2>/dev/null | tail -n1)
        popd
        iopipe_release="${__gitdir}/${release_file}"

        npm install $iopipe_release

        git clone -b "$MEASURE_BRANCH" "$MEASURE_REPO" "$__measuretmp"
        if [ -n $DEBUG ]; then
            pushd $__measuretmp
                echo -n "measure git commit-id: "
                git show-ref -s --heads -- "$MEASURE_BRANCH"
            popd
        fi

        pushd $__measuretmp
            # install dependencies for measure tool
            npm install
        popd
        cp $__measuretmp/data/sls-nodejs8.10.yml serverless.yml
        cp $__measuretmp/data/measure.yml .
        $__measuretmp/main.sh -l nodejs8.10 -h baseline.handler
    popd
}

__gitdir=$(dirname -- $(dirname -- "$0"))
__measuretmp=$(mktemp -d) || exit 1
__runtmp=$(mktemp -d) || exit 1
measure $(mock_release)
rm -rf "$__measuretmp"
rm -rf "$__runtmp"