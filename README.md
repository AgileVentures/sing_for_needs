# Sing For Needs

## Collaborating - Clone Repo

At the command prompt, type:

```
$ git clone https://github.com/AgileVentures/sing_for_needs.git && cd sing_for_needs
```

- Ask to be added as a collaborator:
  - Email [federico](mailto:federico@championer.org?Subject=I%20want%20to%20collaborate%20on%20ChampionerOne) with your Github username, OR
  - Ask @lara-t or @federico in our [AgileVentures.org Slack channel](https://agileventures.slack.com/messages/phoenix_one)

## Install Erlang and Elixir

To work on this project, you will want to make sure you have Erlang and Elixir installed locally.
A great way to manage dependencies is with `asdf`.

Follow the intructions found here for how to [Install asdf-vm](https://asdf-vm.com/#/core-manage-asdf-vm?id=install-asdf-vm)

Don't forget to [Add asdf to your PATH](https://asdf-vm.com/#/core-manage-asdf-vm?id=add-to-your-shell) and restart your shell (opening a new terminal is the easiest way to restart).

You may also need to add asdf to your PATH, in your `.bash_profile` instead of your `.bashrc`, as instructed in the link.

You can have a look at the `.tool-versions` file and you will see that the project is currently using `Elixir 1.8.1`, which is compatible with `Erlang 20.3`.

After you have `asdf` installed correctly, you can run:

```
$ asdf plugin-add elixir
$ asdf plugin-add erlang
$ asdf install
```

This will install the elixir and erlang versions indicated in the [.tool-versions](.tool-versions) file.

You can activate Erlang globally or locally.

Activate globally with:

```
$ asdf global erlang 20.3
```

Activate locally in the current folder with:

```
$ asdf local erlang 20.3
```

(If you're new to Elixir and asdf, activate globally. If you're an asdf & elixir pro, you might want to just activate locally for this project)

Install local.hex and local.rebar:

```
$ mix local.hex --force
$ mix local.rebar --force
```
## SET UP .env
Feel free to skip to the next section if you are using the default postgres username and password as you do not have to set this up.
If you are not using the default postgres username and password, please follow the steps below:
The postgres database Username and Password are configured using a .env file. First copy the content of the .env.dev file in your root directory to a .env file as below
```
cp .env.dev .env
```
 Update the values with the correct username and password, for instance, if the username for my database is `correct_username` and password is `correct_password` I would update as below
```
export POSTGRES_USERNAME="correct_username"
export POSTGRES_PASSWORD="correct_password"
```
 To make the the environmental variabes available on your shell, run the command below:
```
source .env
```
## To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Compile the dependencies with `mix deps.compile`
- Create and migrate your database with `mix ecto.create && mix ecto.migrate`
- Install Node.js dependencies with `cd assets && npm ci`
- Move to the root directory with `cd ..` and start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

- If you get an error that another application is already running in your port 4000, you can set your port dynamically by adding it to the .env file, for example, if you want your application to run on port 5000, you can add the following to your .env
    ```export PORT=5000```
- Reload the .env by running `source .env` in your terminal
- Run the server using command `mix phx.server` and access the app using [`localhost:5000`](http://localhost:5000) 

Now you are fully set up and can join us as a collaborator :smile:


## Docker Development Setup
### Prerequisite
* [Install docker](https://docs.docker.com/install/)
* stop the local instances of *postgres*. 
- In macOS, this is achieved by:
    - brew services stop postgres
- In Ubuntu 18.04, this is achieved by:
    - sudo service postgresql 

### Setup
 Change to the project root directory.

1. Create a `.env` file and populate the following Environment variables as database credentials:
 
 > POSTGRES_USERNAME

 > POSTGRES_PASSWORD

For example:
```
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=postgres
```

 2. Source the `.env` file by running command:
 ```
 $ source .env
 ```


Ensure that you have a stable version of docker on your machine

3. In the terminal, run this command:
- `docker build -f docker/release/Dockerfile -t sing_for_needs:develop . `

4. After the application image has been created by the above command, start the application by running:
- `docker-compose -f docker/release/docker-compose.yml up `

5. Access the application from your browser on `http://localhost:4000`

## Collaborating - Working on an Issue

Sing For Needs utilises **_Zenhub.com_** for project management, mainly because it's easier to use and it enables the developers/collaborators to cooperate efficiently

Head over and check out the [Sing For Needs' Zenhub Board](https://app.zenhub.com/workspaces/sing-for-needs-5c8d188a534a9b0a86cdc451/board?repos=108547295)

The zenhub board is divided into six main pipelines

1. New Issues
2. Icebox
3. Backlog
4. In Progress
5. Review
6. Closed

<img width="1064" alt="Screenshot 2019-04-06 06 34 24" src="https://user-images.githubusercontent.com/11988089/55668942-6ce5f980-5836-11e9-8e0b-3d1d5cef3837.png">

You'll want to **start by looking at the _Backlog_** column where there is a prioritized list of issue cards. The **Icebox** column is also prioritized, from top to bottom. It indicates prioritized tickets that can be worked on but have lower priority than the Backlog tickets that are more likely to be completed within the current 2-week sprint.

When clicking on the cards, a short description of the issue is displayed.
**Once you pick an issue to work on,** from the _Backlog_ or _Icebox_ (look for the _Help Wanted_ or _Good First Issue_ tags), **_create a branch from the terminal_** with the issue and a short description, for example:

```js
//Be sure you create your branch from an up-to-date develop branch
//Don't modify develop. Keep it clean & in sync with this Github repo's develop branch
$ git checkout develop

//Update develop branch
$ git pull

//Create feature branch
$ git checkout -b 17-add-logo
```

**_Remember that you need to move the issue card to the In Progress column_** or add the `in progress` label, so that the team knows you are working on that particular issue.

It's also good practice to push the up the branch right away (this action used to move the issue automatically to `in progress`, with WaffleBot):

```
$ git push --set-upstream origin 17-add-logo
```

Now you're ready to write code.

**After you make your modifications, but before you make your last commit on your code, be sure to run the tests, to ensure no regressions have been introduced:**

```
$ mix test
```

Commit your changes:

```
$ git add -A && git commit -m "Add message describing my changes"
```

When you're ready to submit your changes in a pull-request,

1. first update your develop branch:

```
$ git checkout develop

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

4. Double-check the site runs normally or as intended, in your browser on [`localhost:4000`](http://localhost:4000):

```
$ mix phx.server
```

5. Push up your changes and submit your PR:

```shell
$ git push
```

![Make PR](https://dl.dropbox.com/s/j50pk714r3i872p/Screenshot%202018-06-07%2001.58.45.png)

After submitting a pull-request with a keyword such as _Fixes, Closes,_ or _Resolves_ and the issue # in the PR description (for example, `Fixes #17`), move the issue card once again to the right, into the _Review_ column, where another collaborator will need to review it.
