# Delete

**TODO: Add description**

## Installation

Run `iex -S mix` to compile and start `iex`:

Example:
```elixir
iex(1)> Crypto.start_link("ethereum")
iex(1)> Crypto.start_link("solana")
iex(1)> Crypto.start_link("bitcoin")


iex(1)> Crypto.get_price("ethereum")
iex(2)> Crypto.get_price("solana")
iex(3)> Crypto.get_price("bitcoin")
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/delete>.

# Design URL Shortener in Elixir
user get to input a url -> output a short url
a fn that generate completely random slug
save it into DB
google.com -> /skf3s

