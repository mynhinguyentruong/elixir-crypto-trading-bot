defmodule Delete.Application do
  use Application

  @impl true
  def start(_, _) do

    children = [

      {Registry, keys: :unique, name: Crypto.Registry},
      {Crypto, "ethereum"},
      {Crypto, "solana"},
      {Crypto, "bitcoin"},
      {Registry, keys: :duplicate, name: PubSub.Registry},
      {Task, fn -> Server.listen(3030) end}
    ]

    opts = [strategy: :one_for_one, name: Delete.Application.Supervisor]

    Supervisor.start_link(children, opts)
  end
end


