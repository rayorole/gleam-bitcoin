import bitcoin
import gleam/result
import gleeunit
import gleeunit/should
import types

pub fn main() {
  gleeunit.main()
}

pub fn get_block_count_with_invalid_auth_test() {
  let config = bitcoin.client("localhost", 18_332, "wrong", "wrong")

  bitcoin.get_block_count(config)
  |> should.equal(Error(types.AuthenticationError))
}

pub fn get_block_count_with_invalid_host_test() {
  let config = bitcoin.client("invalid-host", 18_332, "user", "pass")

  bitcoin.get_block_count(config)
  |> should.equal(Error(types.ConnectionError))
}

// Helper function to test equality of configs
fn assert_configs_equal(config1: types.Client, config2: types.Client) {
  config1.config.host
  |> should.equal(config2.config.host)

  config1.config.port
  |> should.equal(config2.config.port)

  config1.config.username
  |> should.equal(config2.config.username)

  config1.config.password
  |> should.equal(config2.config.password)
}

pub fn config_equality_test() {
  let config1 = bitcoin.client("testhost", 8332, "user1", "pass1")
  let config2 = bitcoin.client("testhost", 8332, "user1", "pass1")

  assert_configs_equal(config1, config2)
}
