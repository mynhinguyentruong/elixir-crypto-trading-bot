# Do you know how to set up a server in Elixir

defmodule Server do
  require Logger

  # listen to connection
  def listen(port) do
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    accept_loop(socket)
  end

  # accept connection client
  def accept_loop(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    {:ok, data} = :gen_tcp.recv(client, 0)

    :gen_tcp.send(client, data)

    accept_loop(socket)
  end

  # get data from client

end
