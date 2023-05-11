defmodule KVServer do
  require Logger

  def accept(port) do
    # receive data as binary
    # receive data line by line
    # blocks on :gen_tcp.recv/2 until the data is available
    #
  end

  def loop_acceptor(socket) do
    :gen_tcp.accept(socket)
  end
end
