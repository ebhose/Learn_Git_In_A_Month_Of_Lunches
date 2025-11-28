#!/bin/bash
#
# Execute this in the command line window to make a repository with
# lots of branches.
#
# To run, type:
#
# bash ./make_lots_of_branches.sh
#
# Learn Git in a Month of Lunches (Chapter 9)
# Rick Umali (rickumali@gmail.com)

TARGET_DIR=lots_of_branches

if [ -d $TARGET_DIR ]; then
  echo "'$TARGET_DIR' directory already exists."
  exit 1
fi

mkdir $TARGET_DIR
cd $TARGET_DIR

cat > lorem-ipsum-for-branches.txt <<EOF
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc facilisis
venenatis felis, scelerisque consectetur lacus viverra in. Phasellus
scelerisque pretium nibh, ac porttitor massa vestibulum non. Aenean ornare
convallis enim, et semper neque sagittis ut. Proin blandit dui vitae quam
fermentum, non lacinia lectus molestie. Vivamus tempus viverra dui. Cras in
luctus felis. Pellentesque dictum tortor ipsum, id iaculis felis ultrices ut.
Nunc id velit dignissim, suscipit est ac, euismod libero. Phasellus fringilla,
nibh sit amet consectetur auctor, lorem magna euismod ante, tempor lobortis mi
mi sagittis odio. Donec fermentum sem vel neque pulvinar eleifend.

Nullam posuere condimentum rutrum. Vivamus vitae elit a tellus interdum
accumsan. Duis pretium viverra condimentum. Curabitur dapibus aliquet semper.
Aliquam pretium nunc aliquam pellentesque molestie. Suspendisse potenti. In a
erat sed ante rutrum commodo. Fusce congue nunc aliquet tellus dignissim
fringilla.

Cras non odio gravida, blandit risus sed, tempor lectus. Donec vel congue
mauris. Donec ultrices malesuada dictum. Suspendisse molestie pulvinar quam eu
dignissim. Aliquam eget faucibus neque. Phasellus at nibh dapibus urna
fringilla posuere et a magna. Nullam pharetra nunc lorem, a iaculis massa
consectetur in.

Pellentesque ultricies arcu ac orci congue ultrices. Etiam fermentum erat ante,
eget fringilla urna sagittis vitae. Quisque dictum faucibus faucibus. Mauris
mattis, leo vel malesuada bibendum, magna orci aliquet lectus, a vulputate
augue neque a enim. Maecenas eu augue eros. Pellentesque vestibulum augue porta
sem convallis, nec vulputate ante ullamcorper. Nam laoreet, sapien in fermentum
elementum, ante massa vehicula eros, non luctus ipsum leo a metus.

Nunc velit lacus, pellentesque sit amet libero ac, rutrum facilisis est. Ut
aliquam justo sit amet ornare condimentum. Curabitur nibh est, vehicula at
sodales non, posuere in quam. Quisque ornare rutrum arcu ut porttitor. Nunc
blandit justo eget nisl accumsan, eu auctor urna pretium. Proin non condimentum
tortor, non fermentum lectus. Ut et convallis sapien. Duis luctus viverra diam,
rutrum egestas purus. Duis blandit feugiat lorem, in pellentesque orci tempus
id. In viverra semper nibh ac fringilla. Nullam sit amet accumsan nibh.
EOF

git init
echo "# Comment" > math.sh
git add math.sh
git commit -m "This is the first commit."
echo "a=1" >> math.sh
git commit -a -m "This is the second commit."
echo "b=1" >> math.sh
git commit -a -m "Adding b variable."
touch a b c d
git add a b c d
git commit -m "Adding four empty files."

git tag -a four_files_galore master -m "Jump off point for many many branches"

fill_up()
{
  let num_lines=$((RANDOM % 10))
  touch $1 # Creates at least an empty file
  for ((k=1; k <= $num_lines; k++))
  do
    head -$(($RANDOM%35+1)) lorem-ipsum-for-branches.txt >> $1
  done
}

let num_branches=40
random_branch_1=$((RANDOM%40+1))
random_branch_2=$((RANDOM%40+1))
random_branch_3=$((RANDOM%40+1))
for ((i=1; i <= $num_branches ; i++))
do
  branch_name=$(printf "branch_%02d" $i)
  git checkout -b $branch_name four_files_galore
  let num_files=$((RANDOM % 10 + 1))
  if [ $i -eq 21 ]
  then
    let num_files=$((num_files + 3))
  fi
  for ((j=1; j <= $num_files; j++))
  do
    file="file_$RANDOM"
    fill_up $file
    git add $file
    git commit -m "Commit for $file"
    if [ $i -eq 21 ] && [ $j -eq 2 ]
    then
      file="file_$RANDOM"
      fill_up $file
      git add $file
      git commit -m "Randomly tagged file on Branch 21."
      git tag -a -m "Randomly tagged file." random_tag_on_file
    fi
  done
  if [ $i -eq $random_branch_1 ]
  then
    git tag -a -m "Hurray. Prize Number 1." random_prize_1
  fi
  if [ $i -eq $random_branch_2 ]
  then
    git tag -a -m "Hurray. Prize Number 2." random_prize_2
  fi
  if [ $i -eq $random_branch_3 ]
  then
    git tag -a -m "Hurray. Prize Number 3. Ding!" random_prize_3
  fi
done
rm lorem-ipsum-for-branches.txt
echo $random_branch_1 > answers.txt
echo $random_branch_2 >> answers.txt
echo $random_branch_3 >> answers.txt
git add answers.txt
git commit -m "The answers are in this commit."
git checkout master
