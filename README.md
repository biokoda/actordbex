This is an Elixir connector for ActorDB.

To connect with `:default_pool`:

```
iex> config = ActorDB.Client.create_config(:default_pool, "127.0.0.1", 33306, "user", "pass")
iex> config |> ActorDB.Client.connect
```

Query example with `:default_pool`:

```
iex> ActorDB.Client.exec "actor type1(*); pragma list;"   
{:ok,
 {false,
  [%{actor: "type1actor1"},
   %{actor: "type1actor2"},
   ...]}}
```

To connect with a custom pool with id `:my_pool`:

```
iex> config = ActorDB.Client.create_config(:my_pool, "127.0.0.1", 33306, "user", "pass")
iex> config |> ActorDB.Client.connect
```

Query example for pool `:my_pool`:

```
iex> my_pool = ActorDB.Client.config :my_pool
iex> my_pool |> ActorDB.Client.exec "actor type1(*); pragma list;"
{:ok,
 {false,
  [%{actor: "type1actor1"},
   %{actor: "type1actor2"},
   ...]}}
```

Successful results are:

```
{:ok,
  {:changes, lastInsertRowId, rowsChanged}}

{:ok,
  {has_more, result_set}}
```

Result values are of types:

* `lastInsertRowId` - integer
* `rowsChanged` - integer
* `has_more` - boolean
* `result_set` - list of maps
