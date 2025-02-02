#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
export CI=true
export TRAVIS=true
export CONTINUOUS_INTEGRATION=true
export USER=travis
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export RAILS_ENV=test
export RACK_ENV=test
export MERB_ENV=test
export JRUBY_OPTS="--server -Dcext.enabled=false -Xcompile.invokedynamic=false"
apt-get update && apt-get install -y tzdata postgresql-client libpq-dev libcurl4-openssl-dev cmake libxml2-dev
gem install bundler -v 2.0.1

export TRAVIS_BUILD_DIR=$PWD

#before install
source tools/ci/before_install.sh

#install
bundle install --jobs=3 --retry=3

git config --global user.email "user@domain.com"
git config --global user.name "git user"

#before_script
bundle exec rake test:$TEST_SUITE:setup

#script
bundle exec rake test:$TEST_SUITE
