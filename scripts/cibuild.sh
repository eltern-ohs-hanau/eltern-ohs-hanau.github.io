#!/usr/bin/env bash
set -e # halt script on error

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

rm -rf _posts
git clone --depth 1 https://github.com/eltern-ohs-hanau/eltern-ohs-hanau.wiki.git _posts/
revision=$(git -C _posts/ show --pretty=format:"%h" --no-patch)
rm -rf _posts/.git

bundle exec jekyll build
git add _posts/
git commit -m "ADD wiki commit $revision"
git push