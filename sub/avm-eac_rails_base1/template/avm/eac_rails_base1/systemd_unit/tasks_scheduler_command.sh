#!/bin/bash

set -e

source "$HOME/.rvm/scripts/rvm"
( cd '%%fs_path%%'; RAILS_ENV=production bundle exec tasks_scheduler "$@" )
