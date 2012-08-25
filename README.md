# frontend-openshift-deployment

A small set of utilities to help with deploying Frontend to OpenShift.

# Running

To deploy, make sure Frontend's master branch is in a good state, as this is what we'll
pull from.

Evolutions get applied automatically, on deploy.

**Deploying will cause a minor Frontend outage. Keep this in mind.**

You must have your ssh key added to OpenShift to be able to deploy.

To deploy, run `./deploy.sh` and wait.

This will, in order:

* Clone the latest copy of the Frontend repo.
* Move the openshift.conf config in place.
* Compile Frontend.
* Move the compiled jars out to the current directory
* Remove the unneeded, uncompiled files.
* Commit the result with the timestamp of the commit in the summary.
* Do some cleanup.

# License

This is licensed under Apache 2.0, just like Frontend itself.

```
   Copyright 2012 Breakpoint-Eval

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```
