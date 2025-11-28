#!/bin/bash
#
# Execute this in the command line window to make the example
# repository using the GitHub flow conventions.
#
# To run, type this:
#
# bash ./make_gh_repo.sh
#
# Learn Git in a Month of Lunches (Chapter 17)
# Rick Umali (rickumali@gmail.com)

TARGET_DIR=gh-flow

if [ -d $TARGET_DIR ]; then
  echo "'$TARGET_DIR' directory already exists."
  exit 1
fi

# Right now, in seconds
NOW=$(date +%s)
# In seconds
DAY=$((60 * 60 * 24))
# In seconds
HOUR=$((60 * 60))

#
# Chapter 17
#

# Section 17.4
mkdir $TARGET_DIR
cd $TARGET_DIR
git init
ADJUSTED_DATE=$((NOW - DAY - (HOUR * 4)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit --allow-empty -m "Initial commit"

git checkout -b sum_program
git branch
cat > sum.sh <<EOF
# Add a and b
a=1
b=1
let c=\$a+\$b
printf "This is the answer: %d\n" $c
EOF
git add sum.sh
ADJUSTED_DATE=$((NOW - DAY - (HOUR * 3)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "The sum program"

git checkout master
ADJUSTED_DATE=$((NOW - DAY - (HOUR * 2)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git merge sum_program
