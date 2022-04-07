#!/bin/bash

set -e

source "$HOME/.rvm/scripts/rvm"
( cd '%%fs_path%%'; bundle exec tasks_scheduler "$@" )
