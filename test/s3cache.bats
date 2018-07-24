#!/usr/bin/env bats

load test_helper

setup () {
  export DRONE_REPO="myrepo"
  export DRONE_BRANCH="mybranch"
  export PLUGIN_REGION="eu-west-1"
  export PLUGIN_BUCKET="mybucket"
}

s3cache="./s3cache"

@test "s3cache using pull mode" {
  stub gof3r \
    "get -b mybucket -k myrepo/mybranch/cache.tar --endpoint=s3-eu-west-1.amazonaws.com : echo 123"
  stub tar \
    "-xf 123 : echo 345"

  PLUGIN_MODE="pull" run $s3cache
  assert_success

  #unstub tar
  #unstub gof3r
}

@test "s3cache using push mode" {
  skip
  run s3cache
  assert_success
}