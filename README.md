[![Waffle.io - Columns and their card count](https://badge.waffle.io/AgileVentures/sing_for_needs.svg?columns=all)](https://waffle.io/AgileVentures/sing_for_needs)

# SingForNeeds

To work on this project, you will want to make sure you have Erlang and Elixir installed locally.
A great way to manage dependencies is with `asdf`. You can follow this gist to guide you [Install Elixir](https://gist.github.com/rubencaro/6a28138a40e629b06470)

You can have a look at the `mix.exs` file and you will see that the project is currently using `Elixir 1.4`, which is compatible with `Erlang 20`. 

After you have `asdf` installed correctly, you can run:

```
$ asdf plugin-add elixir
$ asdf plugin-add erlang
$ asdf install
```
This will install the dependencies in the [.tool-versions](.tool-versions) file.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:8080`](http://localhost:8080) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
