defmodule ActorDB.Client do
  @moduledoc """
  Elixir ActorDB interface, using Erlang actordb_client
  """

  @doc """
  Generates a connection configuration term that can be used with `connect`

  Returns '{:default_pool, [size: 10, max_overflow: 5],
           [hostname: '127.0.0.1', port: 33306, username: "testuser",
            password: "testpass"]}'

  ## Examples

    iex> ActorDB.Client.create_config(:default_pool, "127.0.0.1", 33306, "testuser", "testpass")

  """
  def create_config(pool_id, host, port, user, pass) when is_atom(pool_id) do
    pool_info = [size: 10, max_overflow: 5]
    {pool_id, pool_info, [hostname: :erlang.binary_to_list(host), port: port, username: user, password: pass]}
  end

  @doc """
  Connects to ActorDB with single configuration

  Returns `:ok`.

  ## Examples

    iex> config = ActorDB.Client.create_config(:default_pool, "127.0.0.1", 33306, "testuser", "testpass")
    iex> ActorDB.Client.connect(config)

  """

  def connect({_,_,_} = config) do
    :application.ensure_all_started :actordb_client
    [config]
    |> :actordb_client.start
  end

  @doc """
  Connects to ActorDB with multiple configurations

  Returns `:ok`.

  ## Example

    iex> config1 = ActorDB.Client.create_config(:pool1, "127.0.0.1", 33306, "testuser", "testpass")
    iex> config2 = ActorDB.Client.create_config(:pool2, "127.0.0.1", 33306, "testuser2", "testpass2")
    iex> ActorDB.Client.connect([config1, config2])

  """
  def connect(configs) when is_list(configs) do
    :application.ensure_all_started :actordb_client
    :actordb_client.start configs
  end

  @doc """
  Returns a list of actor types that are available on an established connection

  ## Example
    iex> ActorDB.Client.actor_types
    {:ok, ["type1", "type2"]}
  """
  def actor_types do
    :actordb_client.actor_types
  end

  @doc """
  Returns a list of tables within an actor type

  ## Example
    iex> "type1" |> ActorDB.Client.actor_tables
    {:ok,
      ["table1", "table2"]}
  """
  def actor_tables(actor_type) do
    :actordb_client.actor_tables actor_type
  end

  @doc """
  Returns a list of columns present in a table within an actor

  ## Example
    iex> "type1" |>  ActorDB.Client.actor_columns "table1"
    {:ok,
   %{"column1" => "BOOLEAN", "column2" => "INTEGER", "column3" => "TEXT",
     "column4" => "TEXT", ...}}
  """
  def actor_columns(actor_type, actor_table) do
    :actordb_client.actor_columns(actor_type, actor_table)
  end

  @doc """
  Creates a default ActorDB query config

  Query configs can be used to change how the driver behaves towards the client.
  Config defines connection timeout, types that are returned and the pool name that is used for querying.

  Tuple that is returned should be passed as a config parameter to querying functions.

  ## Example
    iex> ActorDB.Client.config
    {:adbc, :atom, :default_pool, :infinity}
  """
  def config do
    :actordb_client.config
  end

  @doc """
  Creates a ActorDB query config with a defined connection pool with `pool_id`

  Query configs can be used to change how the driver behaves towards the client.
  Config defines connection timeout, types that are returned and the pool name that is used for querying.

  Tuple that is returned should be passed as a config parameter to querying functions.

  ## Example
    iex> ActorDB.Client.config
    {:adbc, :atom, :pool_id, :infinity}
  """
  def config(pool_id) when is_atom(pool_id) do
    :actordb_client.config pool_id
  end

  @doc """
  Creates a ActorDB query config with a defined connection pool with `pool_id` and a timeout `timeout`

  Query configs can be used to change how the driver behaves towards the client.
  Config defines connection timeout, types that are returned and the pool name that is used for querying.

  Tuple that is returned should be passed as a config parameter to querying functions.

  ## Example
    iex> ActorDB.Client.config
    {:adbc, :atom, :pool_id, timeout}
  """
  def config(pool_id, query_timeout) when is_atom(pool_id) do
    :actordb_client.config(pool_id, query_timeout)
  end

  @doc """
  Execute a query on the config database.
  """
  def exec_config(sql) do
    :actordb_client.exec_config sql
  end

  @doc """
  Execute a query on the config database.
  """
  def exec_config(config,sql) do
    :actordb_client.exec_config(config, sql)
  end

  @doc """
  Execute a query on schema database.
  """
  def exec_schema(sql) do
    :actordb_client.exec_schema sql
  end

  @doc """
  Execute a query on schema database.
  """
  def exec_schema(config, sql) do
    :actordb_client.exec_schema(config, sql)
  end

  @doc """
  Execute a query on a single actor.
  """
  def exec_single(actor, type, sql, flags) do
    :actordb_client.exec_single(actor, type, sql, flags)
  end

  @doc """
  Execute a query on a single actor.
  """
  def exec_single(config, actor, type, sql, flags) do
    :actordb_client.exec_single(config, actor, type, sql, flags)
  end

  @doc """
  Execute a parametrized query on a single actor.
  """
  def exec_single_param(actor, type, sql, flags, binds) do
    :actordb_client.exec_single_param(actor, type, sql, flags, binds)
  end

  @doc """
  Execute a parametrized query on a single actor.
  """
  def exec_single_param(config, actor, type, sql, flags, binds) do
    :actordb_client.exec_single_param(config, actor, type, sql, flags, binds)
  end

  @doc """
  Execute a query on multiple actors.
  """
  def exec_multi(actors, type, sql, flags) when is_list(actors) do
    :actordb_client.exec_multi(actors, type, sql, flags)
  end

  @doc """
  Execute a query on multiple actors.
  """
  def exec_multi(config, actors, type, sql, flags) when is_list(actors) do
    :actordb_client.exec_multi(config, actors, type, sql, flags)
  end

  @doc """
  Execute a query on all actors of a same type.
  `type(*)``
  """
  def exec_all(type, sql, flags) do
    :actordb_client.exec_all(type, sql, flags)
  end

  @doc """
  Execute a query on all actors of a same type.
  `type(*)``
  """
  def exec_all(config, type, sql, flags) do
    :actordb_client.exec_all(config, type, sql, flags)
  end

  @doc """
  Execute a raw query.
  """
  def exec(sql) do
    :actordb_client.exec(sql)
  end

  @doc """
  Execute a raw query.
  """
  def exec(config, sql) do
    :actordb_client.exec(config, sql)
  end

  @doc """
  Execute a raw parametrized query.
  """
  def exec_param(sql, binds) do
    :actordb_client.exec_param(sql, binds)
  end

  @doc """
  Execute a raw parametrized query.
  """
  def exec_param(config, sql, binds) do
    :actordb_client.exec_param(config, sql, binds)
  end

  @doc """
  Returns protocol version.
  """
  def prot_version do
    :actordb_client.prot_version
  end

end
