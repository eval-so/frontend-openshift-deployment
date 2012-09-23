cd `dirname $0`
git clone git://github.com/breakpoint-eval/frontend
cp openshift.conf frontend/conf/

pushd frontend
  mv conf/application.conf.dist conf/application.conf
  sbt clean update compile stage
popd

mv frontend/target/staged/ .
mv frontend/target/start .

rm -rf frontend

git add .
git commit -m "Deploying from upstream at: `date`"
git push origin master

rm -rf staged start
