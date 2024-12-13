import gleam/io
import gleam/result
import types
import util/http

pub fn client(
  host: String,
  port: Int,
  username: String,
  password: String,
) -> types.Client {
  let config =
    types.Config(host: host, port: port, username: username, password: password)
  types.Client(config: config)
}

pub fn get_block_count(client: types.Client) -> Result(Int, types.BitcoinError) {
  use response <- result.try(http.send_request(client.config, "getblockcount"))
  io.debug(response)
  // TODO: Parse JSON response to get block count
  // For now returning a dummy value
  Ok(0)
}
