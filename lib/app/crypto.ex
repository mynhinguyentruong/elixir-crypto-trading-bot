defmodule Crypto do
  use GenServer

  defstruct [:symbol, :price]
  # %Crypto{symbol: value, price: value}

  def child_spec(arg) do
    %{
      id: arg,
      start: {Crypto, :start_link, [arg]}
    }
  end

  def start_link(symbol) do # SOL
    name = via_tuple(symbol)
    GenServer.start_link(__MODULE__, %Crypto{symbol: symbol}, name: name) # default price 0

    loop_get_price(symbol)
  end

  def via_tuple(symbol) do
    {:via, Registry, {Crypto.Registry, symbol}}
  end

  def get_price(symbol) do
    GenServer.call(via_tuple(symbol), {:get_price, symbol})
  end

  def loop_get_price(symbol) do
    get_price(symbol)

    Process.sleep(30000) # every 30 sec because rate limit 10-30 calls/min

    loop_get_price(symbol)
  end


  @impl true
  def handle_call({:get_price, symbol}, _from, state) do
    # HTTP REQ to get update price
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.get("https://api.coingecko.com/api/v3/simple/price?ids=#{symbol}&vs_currencies=usd&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true&precision=18")
    %{
      "last_updated_at" => last_updated_at,
      "usd" => usd_price,
      "usd_24h_change" => usd_24h_change,
      "usd_24h_vol" => usd_24h_vol,
      "usd_market_cap" => usd_market_cap
    }
    = Jason.decode!(body)[symbol] # an array, list of map
    IO.puts("Received #{symbol} price at $#{usd_price}")
    {:reply, usd_price, Map.put(state, :price, usd_price)}
  end
end

#Start this GenServer under Supervisor
