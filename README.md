# Welcome to tx-dashboard 🚀

![Version](https://img.shields.io/badge/version-0.1.0-blue.svg?cacheSeconds=2592000)
[![Documentation](https://img.shields.io/badge/documentation-yes-brightgreen.svg)](https://github.com/eduardo-rdguez/tx-dashboard/blob/main/README.md)
[![Depfu](https://badges.depfu.com/badges/132e214a46b09db690da6b8b10656b63/overview.svg)](https://depfu.com/github/eduardo-rdguez/tx-dashboard?project_id=34714)

> This project has been developed with Elixir, Phoenix and RabbitMQ to demonstrate how LiveView works.

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## RabbitMQ

Run a RabbitMQ Docker image in a container:

```sh
docker run --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.9-management
```

## PostgreSQL

Run a Postgres Docker image in a container:

```sh
docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres
```

## Learn more

* Official website: <https://www.phoenixframework.org/>
* Guides: <https://hexdocs.pm/phoenix/overview.html>
* Docs: <https://hexdocs.pm/phoenix>
* Forum: <https://elixirforum.com/c/phoenix-forum>
* Source: <https://github.com/phoenixframework/phoenix>
* RabbitMQ: <https://www.rabbitmq.com/tutorials/tutorial-one-python.html>

## Author

* Website: <https://eduardo-rdguez.github.io/>
* Twitter: [@\_eduardguez](https://twitter.com/\_eduardguez)
* Github: [@eduardo-rdguez](https://github.com/eduardo-rdguez)
