# Sing-for-needs

## Collaborating- Clone Repo

## Clone the repo
At the command prompt type:
```
$ git clone https://github.com/AgileVentures/sing_for_needs.git
```

Ask to be added as a collaborator
	Email @federico with your Github username


## To start your Phoenix Server
 1. Install dependencies using 
 ```
 mix deps.get
 ```
 2. Compile the dependencies using 
 ```
 mix deps.compile
 ```
 3. Move to the root directory
 ```
cd ..
```
 4. Start Phoenix endpoint with 
 ```
 mix phx.server
 ```
* Visit 
```
localhost:4000
```

## Collaborating -use of WaffleBot

Sing-For-Needs utilises ***Waffle.io*** for project management mainly because its easier to use and enables the developers/collaborators to cooperate efficiently

Head over and check out ***Sing-For-Needs Board***
 
The waffle board is divided into six columns

1. Inbox
2. Backlog
3. InProgress
4. Review
5. Done
6. Deployed


Issue numbers are displayed at the top left corner.Onclicking the numbers a short description of the issue is displayed.
Once you pick an issue create a ***branch from the terminal*** with the issue and a short description eg.

* **Be sure you create your branch from an up-to-date develop branch**

* **Don't modify develop. Keep it clean & in sync with your repos**

```
$ git checkout develop
```

* To update develop branch
```
$ git pull
```

* To create feature branch
```
$ git checkout -b 17-add-logo
```

or you can create a branch directly from Github

When creating it from your terminal, ***remember that you need to push the branch to the GitHub repo***
for  Waffle to  knows you are working on that particular  issue  e.g. 
```
$ git push --set-upstream origin 17-add-logo
```

Now you're ready to change write  code, and because your branch starts with the **issue#**, WaffleBot will have automatically moved the issue card to the In Progress column, letting people know you are working on a specific issue.

* **After you make your modifications, but before you make your last commit on your code, be sure to run the tests, to ensure no regressions have been introduced:**
```
chromedriver & mix test && pkill chromedriver
```

* Commit your changes:

```
$ git add -A && git commit -m "Add message describing my changes"
```

When you're ready to submit your changes in a pull-request, 

1. first update your develop & your feature branch:
```
$ git checkout develop
```
```
$ git pull
```

2. Switch back to your feature branch
```
$ git checkout 17-add-logo
```

3. Update your feature branch by merging develop
```
$ git merge develop
```
4. Double-check the site runs normally or as intended, in your browser on localhost:4000: 
``` 
$ mix phx.server
````
5. Push up your changes and submit your PR:
``` shell
$ git push
```


After submitting a pull-request with a keyword such as Fixes, Closes, or Resolves and the issue# in the PR description (for example, Fixes #17), WaffleBot moves the issue card once again to the right, into the Needs Review column, where another collaborator will need to review it.

You can always edit and prepend Work-In-Progress to your PR title, to let the team know that your PR is not finished yet (e.g. [WIP] 17 add logo).

Now you are fully setup and can join us as a collaborator :smile:
