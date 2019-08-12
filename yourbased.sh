#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
export RAILS_ENV=test
apt-get update && apt-get install -y tzdata
gem install bundler -v 2.0.1

#before install
source tools/ci/before_install.sh

#install
bundle install --jobs=3 --retry=3

#before_script
bundle exec rake test:$TEST_SUITE:setup

#script
bundle exec rake test:$TEST_SUITE
