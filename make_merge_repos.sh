#!/bin/bash
#
# Execute this in the command line window to make a repository 
# that is in position to do a 'true merge'.
#
# Type this:
#
# bash ./make_merge_repos.sh
#
# Learn Git in a Month of Lunches (Chapter 10)
# Rick Umali (rickumali@gmail.com)

TARGET_DIR=mergesample

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

cat > baz <<EOF
a=1
b=0
let c=\$a/\$b
EOF
git add baz
git commit -m "Committing baz."

git tag -a bug_here -m "There's a bug here I think."

touch foo
git add foo
git commit -m "Committing foo."

touch bar
git add bar
git commit -m "Committing bar."

git checkout -b bugfix bug_here

cat > baz <<EOF
a=1
b=0
let c=\$a/\$b
echo \$c
EOF
git add baz
git commit -m "Adding echo to check error."

cat > baz <<EOF
a=1
b=1
let c=\$a/\$b
echo \$c
EOF
git add baz
git commit -m "Ugh, I was dividing by zero!"

