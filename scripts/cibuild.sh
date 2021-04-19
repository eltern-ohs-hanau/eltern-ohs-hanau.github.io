#!/usr/bin/env bash
set -e # halt script on error

rm -rf _posts
git clone --depth 1 https://github.com/eltern-ohs-hanau/eltern-ohs-hanau.wiki.git _posts/
revision=$(git -C _posts/ show --pretty=format:"%h" --no-patch)
rm -rf _posts/.git

bundle exec jekyll build