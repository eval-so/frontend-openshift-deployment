#!/usr/bin/env bash
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $DIR
git rm -rf staged start
git commit -m "Deploying from upstream at: `date`"
git clone git://github.com/breakpoint-eval/frontend
cp openshift.conf frontend/conf/

pushd frontend
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
