import gleam/http.{Post}
import gleam/http/request
import gleam/httpc
import gleam/int
import gleam/json
import gleam/string
import types

pub fn send_request(
  config: types.Config,
  method: String,
) -> Result(String, types.BitcoinError) {
  // Construct the RPC URL
  let url =
    string.concat(["http://", config.host, ":", int.to_string(config.port)])

  // Create basic auth header
  let auth =
    base64_encode(string.concat([config.username, ":", config.password]))
  let auth_header = string.concat(["Basic ", auth])

  // Prepare request body
  let body =
    json.object([
      #("jsonrpc", json.string("1.0")),
      #("id", json.string("gleam-bitcoin")),
      #("method", json.string(method)),
      #("params", json.array([], of: json.string)),
    ])
    |> json.to_string

  // Prepare HTTP request
  let assert Ok(req) = request.to(url)
  let req =
    req
    |> request.set_method(Post)
    |> request.set_body(body)
    |> request.prepend_header("Authorization", auth_header)
    |> request.prepend_header("Content-Type", "application/json")

  // Send request
  case httpc.send(req) {
    Ok(resp) ->
      case resp.status {
        200 -> Ok(resp.body)
        status -> Error(types.HttpError(status))
      }
    Error(_) -> Error(types.ConnectionError)
  }
}

fn base64_encode(input: String) -> String {
  // TODO: Implement proper base64 encoding
  // For now, returning a dummy value
  input
}
