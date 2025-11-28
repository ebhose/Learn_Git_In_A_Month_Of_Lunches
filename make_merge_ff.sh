#!/bin/bash
#
# Execute this in the command line window to make a repository 
# that is in position to do a 'fast-forward merge'.
#
# To run, type:
#
# bash ./make_merge_ff.sh
#
# Learn Git in a Month of Lunches (Chapter 10)
# Rick Umali (rickumali@gmail.com)

TARGET_DIR=ff

if [ -d $TARGET_DIR ]; then
  echo "'$TARGET_DIR' directory already exists."
  exit 1
fi

mkdir $TARGET_DIR
cd $TARGET_DIR
git init
cat > README.txt <<EOF
This repo contains two branches that can be merged via
a fast-forward merge.
EOF
git add README.txt
git commit -m "Committing the README."

touch baz
git add baz
git commit -m "Committing baz."

git checkout -b new_feature

touch foo
git add foo
git commit -m "Committing foo."

touch bar
git add bar
git commit -m "Committing bar."
