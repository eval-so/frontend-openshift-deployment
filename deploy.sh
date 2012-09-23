cd `dirname $0`
git rm -rf staged start
git commit -m "Deploying from upstream at: `date`"
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
git commit --am -m "Deploying from upstream at: `date`"
git push origin master
