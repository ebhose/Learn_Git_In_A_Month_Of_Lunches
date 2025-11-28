#!/bin/bash
#
# Execute this in the command line window to make the example
# repository using the git-flow conventions.
#
# To run, type this:
#
# bash ./make_nvie_repo.sh
#
# Learn Git in a Month of Lunches (Chapter 17)
# Rick Umali (rickumali@gmail.com)

TARGET_DIR=nvie

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

# Section 17.3.1
# TRY IT NOW #1
mkdir $TARGET_DIR
cd $TARGET_DIR
git init
ADJUSTED_DATE=$((NOW - (DAY * 4) - (HOUR * 4)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit --allow-empty -m "Initial commit"
git branch develop
git branch

# TRY IT NOW #2
git checkout -b feature/sum develop
git branch
cat > sum.sh <<EOF
# Add a and b
a=1
b=1
let c=\$a+\$b
printf "This is the answer: %d\n" $c
EOF
git add sum.sh
ADJUSTED_DATE=$((NOW - (DAY * 4) - (HOUR * 3)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "The sum program"

# TRY IT NOW #3
git checkout develop
# TODO Can I pass in a message
ADJUSTED_DATE=$((NOW - (DAY * 3) - (HOUR * 2)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git merge --no-ff feature/sum
git branch -d feature/sum

# Section 17.3.2

# TRY IT NOW: Part 1
git checkout -b release-1.0 develop
rm -f sum.sh
cat > sum.sh <<EOF
# Version 1.0
# Add a and b
a=1
b=1
let c=\$a+\$b
printf "This is the answer: %d\n" $c
EOF
ADJUSTED_DATE=$((NOW - (DAY * 3) - (HOUR * 1)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -a -m "Bumping to version 1.0"

# TRY IT NOW: Part 2
git checkout master
ADJUSTED_DATE=$((NOW - (DAY * 2) - (HOUR * 8)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git merge --no-ff release-1.0
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git tag -a V1.0 -m "Version 1.0"

# TRY IT NOW: Part 3
git checkout develop
ADJUSTED_DATE=$((NOW - (DAY * 2) - (HOUR * 7)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git merge --no-ff release-1.0
git branch -d release-1.0
