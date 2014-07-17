#!/usr/bin/env bash

set -e

# setup variables
export GOVM_SELF_REPO_URL=$PWD
export GOVM_ROOT=$PWD/.test
export GOROOT=$GOVM_ROOT/versions/current
export PATH=$GOROOT/bin:$PATH

echo "setup govm"
rm -rf $GOVM_ROOT
$GOVM_SELF_REPO_URL/bin/govm setup >/dev/null

# setup hg repository
echo "setup hg repository"
export GOVM_REPO_URL=$GOVM_ROOT/.repo
$GOVM_SELF_REPO_URL/test/hg/setup.bash

# run each test
tests=(install use list_remote list)
for test in ${tests[@]}; do
  echo "test $test"
  eval "./test/test-${test}.bash"
  echo "test $test ok"
done
