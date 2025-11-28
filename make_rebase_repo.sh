#!/bin/bash
#
# Execute this in the command line window to make the math repository.
# This particular version does not have a change that needs to be committed
# or reset at the end.
#
# To run, type this:
#
# bash ./make_rebase_repo.sh
#
# Learn Git in a Month of Lunches (Chapter 16)
# Rick Umali (rickumali@gmail.com)

TARGET_DIR=math

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
# Chapter 6
#
mkdir $TARGET_DIR
cd $TARGET_DIR
git init
echo "# Comment" > math.sh
git add math.sh
ADJUSTED_DATE=$((NOW - (DAY * 3) - (HOUR * 4)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "This is the first commit."
echo "a=1" >> math.sh
ADJUSTED_DATE=$((NOW - (DAY * 3) - (HOUR * 2)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -a -m "This is the second commit."
echo "b=1" >> math.sh
ADJUSTED_DATE=$((NOW - (DAY * 3) - HOUR))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -a -m "Adding b variable."
touch a b c d
git add .
ADJUSTED_DATE=$((NOW - (DAY * 3)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Adding four empty files."

#
# Chapter 6: Lab
#
echo "This is a README file. Enjoy." > readme.txt
git add readme.txt
ADJUSTED_DATE=$((NOW - (DAY * 2)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Adding readme.txt"

#
# Chapter 7
#
git rm a b
ADJUSTED_DATE=$((NOW - (DAY * 1) - (HOUR * 2)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Removed a and b."
git mv c renamed_file
git mv d another_rename
ADJUSTED_DATE=$((NOW - (DAY * 1) - HOUR))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Renaming c and d."
cat > math.sh <<EOF
# Add a and b
a=1
b=1
let c=\$a+\$b
echo \$c
EOF
git add math.sh
ADJUSTED_DATE=$((NOW - (DAY * 1)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Adding two numbers."

#
# Chapter 8
#
cat > math.sh <<EOF
# Add a and b
a=1
b=1
let c=\$a+\$b
printf "This is the answer: %d\n" \$c
EOF
git add math.sh
cat > commit.msg <<EOF
Adding printf.

This is to make the output a little more human readable.

printf is part of BASH, and it works just like C's printf()
function.
EOF
ADJUSTED_DATE=$((NOW - (HOUR * 13)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -F commit.msg
rm -f commit.msg

FOUR=$(git rev-parse ":/Adding four empty files")
git tag -a four_files_galore -m "The commit with four files" $FOUR

#
# Chapter 9
#
git branch new_feature
git checkout new_feature
echo "new file" > newfile.txt
git add newfile.txt
ADJUSTED_DATE=$((NOW - (HOUR * 12)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Adding a new file to a new branch"
echo "another new file" > file3.c
git add file3.c
ADJUSTED_DATE=$((NOW - (HOUR * 11)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Starting a second new file"

git checkout master
echo "A small update." >> readme.txt
ADJUSTED_DATE=$((NOW - (HOUR * 10)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -a -m "A small update to readme."

# RENAME=$(git rev-parse ":/Renaming c and d")
# git branch fixing_readme $RENAME
# git checkout fixing_readme
# git checkout -b another_fix_branch fixing_readme
# git branch -d fixing_readme

RENAME=$(git rev-parse ":/Renaming c and d")
git checkout -b another_fix_branch $RENAME
git checkout master
