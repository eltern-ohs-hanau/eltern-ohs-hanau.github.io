#!/usr/bin/env bash
set -e # halt script on error

rm -rf _posts
git clone --depth 1 https://github.com/eltern-ohs-hanau/eltern-ohs-hanau.wiki.git _posts/
revision=$(git -C _posts/ show --pretty=format:"%h" --no-patch)
rm -rf _posts/.git

# extracts frontmatter from file
# and prepends date to the filename
# or else remove file
for f in _posts/*.md; do
  header="$(sed -n '1,/---/p' $f | sed '1d;$d')"
  prefix="$(echo $header | grep -Po 'date:\W\K(....-..-..)')"
  if [ -z "$prefix" ] || \
     [ -z "$(echo $header | grep -Po 'title:\W\K.*')" ] || \
     [ -z "$(echo $header | grep -Po 'layout:\W\K.*')" ] || \
     [ -z "$(echo $header | grep -Po 'category:\W\K.*')" ]
  then
      rm "$f"
  else
      mv "$f" "$(dirname $f)/$prefix-$(basename $f)"
  fi
done

bundle exec jekyll build --verbose
