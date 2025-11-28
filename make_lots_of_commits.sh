#!/bin/bash
#
# Execute this in the command line window to make a repo with 
# lots of commits in it.
#
# To run, type:
#
# bash ./make_lots_of_commits.sh
#
# Learn Git in a Month of Lunches (Chapter 8)
# Rick Umali (rickumali@gmail.com)

TARGET_DIR=lots_of_commits

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

mkdir $TARGET_DIR
cd $TARGET_DIR
git init

file_name=$(printf "file_%02d" $((RANDOM % 5)))
touch $file_name
cat >> $file_name <<EOF
  The very first line ever.
EOF
git add $file_name
ADJUSTED_DATE=$((NOW - (DAY * 5)))
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "The very first commit. Hi!"

num_commits=$((RANDOM%10+1))
for ((i=1; i <= $num_commits; i++))
do
  file_name=$(printf "file_%02d" $((i % 5)))
  touch $file_name
  cat >> $file_name <<EOF
  Random line. $RANDOM
EOF
  git add $file_name
  ADJUSTED_DATE=$((NOW - (DAY * 4) + (HOUR * i)))
  env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Randomly added contents."
done

cat > program.sh <<EOF
printf "This is small program.\n"
EOF
git add program.sh
cat > commit.msg <<EOF
Commit message.

Word of the day: ubiquitous.
EOF
ADJUSTED_DATE=$((NOW - (DAY * 3) - HOUR)) 
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -F commit.msg
rm -f commit.msg

cat >> program.sh <<EOF
printf "That has been given one more line.\n"
EOF
git add program.sh
cat > commit.msg <<EOF
Commit message.

Word of the day: astounding.
EOF
ADJUSTED_DATE=$((NOW - (DAY * 3))) 
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -F commit.msg
rm -f commit.msg

num_commits=$((RANDOM%20+1))
for ((i=1; i <= $num_commits; i++))
do
  file_name=$(printf "file_%02d" $((i % 5)))
  touch $file_name
  cat >> $file_name <<EOF
  Random line. $RANDOM
EOF
  git add $file_name
  ADJUSTED_DATE=$((NOW - (DAY * 2) + (HOUR * i))) 
  env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "More randomly added contents."
done

cat >> program.sh <<EOF
printf "An all important third line!\n"
EOF
git add program.sh
cat > commit.msg <<EOF
Commit message.

We need this third line!
EOF
ADJUSTED_DATE=$((NOW - (DAY * 2) + (HOUR * 21))) 
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE GIT_AUTHOR_NAME="Rodrigo Umali" GIT_AUTHOR_EMAIL="rgu@freeshell.org" git commit -F commit.msg
rm -f commit.msg

num_commits=$((RANDOM%10+1))
for ((i=1; i <= $num_commits; i++))
do
  file_name=$(printf "file_%02d" $((i % 5)))
  touch $file_name
  cat >> $file_name <<EOF
  A random number line. $RANDOM
EOF
  git add $file_name
  ADJUSTED_DATE=$((NOW - (DAY * 1))) 
  env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Even more randomly added contents."
done

num_commits=$((RANDOM%10+1))
for ((i=1; i <= $num_commits; i++))
do
  file_name=$(printf "file_%02d" $((i % 5)))
  touch $file_name
  cat >> $file_name <<EOF
  A random number line. $RANDOM
EOF
done
git add file_*
ADJUSTED_DATE=$((NOW - (DAY * 0))) 
env GIT_AUTHOR_DATE=$ADJUSTED_DATE GIT_COMMITTER_DATE=$ADJUSTED_DATE git commit -m "Committing all files at once."
