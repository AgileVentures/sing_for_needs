#!/usr/bin/env bash

mix ecto.create
mix ecto.migrate
mix phx.server
