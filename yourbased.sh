#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
export RAILS_ENV=test
apt-get update && apt-get install -y tzdata
gem install bundler -v 2.0.1
# install
bin/setup
# script
rake

bundle exec codeclimate-test-reporter
