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
      {:name, {:local, :worker}},
      {:worker_module, PoolboyApp.Worker},
      {:size, 5},
      {:max_overflow, 2}
    ]
  end
end
