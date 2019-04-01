[![Waffle.io - Columns and their card count](https://badge.waffle.io/AgileVentures/sing_for_needs.svg?columns=all)](https://waffle.io/AgileVentures/sing_for_needs)

# SingForNeeds

## Clone the repo
```
git clone https://github.com/AgileVentures/sing_for_needs.git
cd sing_for_needs
```

## Install Erlang and Elixir
To work on this project, you will want to make sure you have Erlang and Elixir installed locally.
A great way to manage dependencies is with `asdf`. 

Follow the intructions found here for how to [Install asdf-vm](https://asdf-vm.com/#/core-manage-asdf-vm?id=install-asdf-vm)

Don't forget to [Add asdf to your PATH](https://asdf-vm.com/#/core-manage-asdf-vm?id=add-to-your-shell) and restart your shell (opening a new terminal is the easiest way to restart).

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
    asdf global erlang 20.3
```
Activate locally in the current folder with:
```
    asdf local erlang 20.3
```
(If you're new to Elixir and asdf, activate globally. If you're an asdf & elixir pro, you might want to just activate locally for this project)


Install local.hex and local.rebar:

```
mix local.hex --force
mix local.rebar --force
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `cd .. && mix phx.server`

Now you can visit [`localhost:8080`](http://localhost:8080) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
