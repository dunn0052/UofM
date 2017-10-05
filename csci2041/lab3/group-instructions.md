# Group instructions for Lab 3

*CSci 2041: Advanced Programming Principles, Fall 2017 (afternoon)*

**These instructions will only work if executed during the lab period.**  If they are not followed, **you will not receive a grade for your group's work**.

## Setting up a group repository

These instructions should be followed by at least one team member:

* Change directory to your personal repository, something like:

    ```
    % cd csci2041/repo-user1234/
    ```

* Create a file named `lab3_group.txt`, that has the umn user name of each group member on a separate line.  You can do this with a text editor, or simply using the command line:

    ```
    % cat >lab3_group.txt <<EOF
    user1234
    user5678
    user3142
    EOF
    %
    ```

  (Here you should replace the userNNNNs with actual ids)  Remember that you can work in groups of at most three students - four students can become two groups, and if you are working by yourself, there is no need for a student repository.

* Add the change to your repository, commit it locally, and push to github:

    ```
    % git add lab3_group.txt
    % git commit -m 'adding lab 3 group'
    % git push
    ```

* At this point, the git bot should create a group name specific to your team and the current lab.  If you wait 5 seconds and do a `git pull` (or look at your repo on github) you should see a new file named `lab3_groupsetup.md`.  It will contain the name of your group repo, something like `repo-g3_uza93m`.  You should now see this repository under the `csci2041-f17a` organization in github and any member of the group can now clone this repository just like your personal repository:

    ```
    % cd ..
    % git clone https://github.umn.edu/csci2041-f17a/repo-g3_uza93m
    % cd repo-g3_uza93m
    ```

   (If you have set up an ssh key in github, you can change the URL in the second line to reflect this.)

   You should now proceed with the lab using `repo-g3_uza93m` (or whatever is in the `lab3_groupsetup.md` file) in place of your personal repo.


**Important Notes**
* The contents of the `lab3/` directory of this repository will be written over the `lab3/` directory in all group members' personal repos at grading time.  Git is version control software, so you can roll back the changes, but you'll have less headaches if you don't put anything in the `lab3/` directory of your personal repo before submission.

* **ONLY THE WORK THAT APPEARS IN YOUR GROUP REPOSITORY WILL BE GRADED.** If you set up a group and do not complete, commit, and push the group work in the group repo, you will not get credit for the lab.

* **YOUR WORK MUST APPEAR IN A `lab3/` DIRECTORY** inside the group repo.  If it doesn't, the auto-grading scripts won't find it and you won't receive credit for completing the lab.
