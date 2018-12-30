#!/usr/bin/env bash
set -e

export SCRIPT_HOME=$( cd "$( dirname "$0" )" &> /dev/null && pwd )
export LOC=git@github.com:sireum/act-plugin-update-site.git

cd ..
read -p "Warning: this will recreate $LOC.  Proceed? " -n 1 -r; echo 
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Remove the history
  rm -rf .git

  # recreate the repos from the current content only
  git init
  git add .

  DATE=`date +%Y-%m-%d`
  COMMIT_MESSAGE="$DATE release"
  
  read -p "Commit message will be \"$COMMIT_MESSAGE\".  Do you want to provide a custom message? " -n 1 -r; echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Enter commit message: " -r
    COMMIT_MESSAGE=$REPLY
  fi
  git commit -m "$COMMIT_MESSAGE"

  # push to the github remote repos ensuring you overwrite history
  git remote add origin $LOC
  git push -u --force origin master
  

  # merge act dev branch to master  
  #export TMP_DIR=$SCRIPT_HOME/tmp
  #mkdir $TMP_DIR
  #cd $TMP_DIR
  #git clone git@github.com:sireum/act-plugin.git
  #cd act-plugin
  #git checkout master
  #git merge origin/dev
  #git push
  #cd ..
  #rm -rf $TMP_DIR
  
fi
