# Xweeter

## Dependencies
1. Erlang 27.2.2
2. Elixir 1.18.2
3. Phoenix 1.7.19

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Database

Run the command:
```sh
docker run --privileged --name xweeter_database -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=xweeter_dev -p 5432:5432 -d postgres
```

Generate schema:

```sh
mix phx.gen.schema User user name:string email:string password:string status:integer
```

migrate schema

```sh
mix ecto.migrate
```

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
