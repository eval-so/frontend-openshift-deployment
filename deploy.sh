#!/usr/bin/env bash
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $DIR
git rm -rf staged start
rm -rf frontend
git commit -m "Deploying from upstream at: `date`"
git clone git@github.com:breakpoint-eval/frontend

pushd frontend

  # Do documentation stuff.
  temp=`mktemp -d`
  if [[ ! "$temp" == "" ]]; then
    sbt doc
    mv target/scala-*/api/* $temp
    rm -rf project target
    git checkout gh-pages
    git rm -rf *
    mv $temp/* .
    git add .
    git commit -m "Updating documentation from master (via deploy.sh)"
    git push origin gh-pages
    git checkout master
  else
    echo "Bailing out, somehow \$temp is '' and something bad happened."
    exit 1
  fi

  cp ../openshift.conf ./conf/
  mv conf/application.conf.dist conf/application.conf
  for file in $(find ./app/assets/ -type f -print); do
    gzip -c -9 $file > $file.gz
    echo "[*] gzipping static assets."
  done
  sbt clean update compile stage
popd

mv frontend/target/staged/ .
mv frontend/target/start .

rm -rf frontend

git add .
git commit --am -m "Deploying from upstream at: `date`"
git push origin master
popd
