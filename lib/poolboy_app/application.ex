defmodule PoolboyApp.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      :poolboy.child_spec(:worker, poolboy_config())
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PoolboyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  #####################
  # Private Functions #
  #####################

  defp poolboy_config do
    [
      # Named the pool :worker and set scope to :local
      {:name, {:local, :worker}},
      # Set module for the worker
      {:worker_module, PoolboyApp.Worker},
      # Set pool size
      {:size, 5},
      # In case everything is uder load, create two more workers. They go away
      #
      {:max_overflow, 2}
    ]
  end
end
