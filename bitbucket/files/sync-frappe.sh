#!/bin/bash

REPO_NAME=frappe.git
ORIGIN_URL=https://github.com/frappe/$REPO_NAME
GIT_URL=https://admin:TV%21c%29ZhL@git.example.ir/scm/oss/$REPO_NAME
DIR_PATH=/root/infra/services/bitbucket/files/repo/$REPO_NAME

OUT=/root/infra/services/bitbucket/files/repo/sync-${REPO_NAME}.out

echo "" >> $OUT
echo "--------" >> $OUT
echo "$(date)" >> $OUT
if [ -d "$DIR_PATH" ]
then
    echo "Directory exists." >> $OUT
else
    echo "Error: Directory does not exists." >> $OUT
    git clone --bare $ORIGIN_URL $DIR_PATH >>  $OUT
fi

cd $DIR_PATH >> $OUT
git fetch origin --tags >> $OUT ;
remote=origin ; for brname in `git branch -r | grep $remote | grep -v /master | grep -v /HEAD | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'`; do git branch --track $brname $remote/$brname || true; git pull --all; done 2>/dev/null
git remote remove bb && git remote add --mirror=fetch bb $GIT_URL
git fetch bb --tags
git push bb --all ; git push bb --tags
