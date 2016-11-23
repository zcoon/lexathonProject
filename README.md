# lexathonProject
navigate to the folder where you want to keep your code (via terminal)

copy this url : https://github.com/zcoon/lexathonProject.git

run the command `git clone https://github.com/zcoon/lexathonProject.git`

now you have the repo "pulled" into that directory.

If you want to create your own branch to work on,
Run `git checkout -b newBranchName`

If you want to see which branch you are on,
Run `git status`
This will also show you all the files you've edited.

If you want to commit and push all the files you changed,
Run `git add .` (the period is necessary, it means it will add everything that has been changed in the directory. You can see all these files when you run `git status`)
After that Run `git commit -m "And then write your commit message in these quotes. It should describe the changes you just made" `

After that run `git push` and then your code will be pushed to the repo. 

Important - You probably shouldn't work directly on the master branch. It's better if you work on your own branch, and then merge changes into master. 

Also, ALWAYS make sure you run `git pull` when you switch to a branch you haven't been working on and you are about to make changes. "Pulling" downloads the latest version of the code so that your branch is up to date.

So the way this works is when you run git status, it'll tell you which branch you're on. If you're on master and you want to switch to another branch you'll Run git checkout otherBranch (where otherBranch is the name of the branch).

When you want to merge code into master, you will actually be on master, and then you'll run `git merge branchIWantToMerge` (this will merge the code from branchIWantToMerge into master). With this you might need to resolve merge conflicts. I'm glad to handle this part because it can be tricky.

Good luck. Let me know if you have questions.

