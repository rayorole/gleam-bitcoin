pub type Config {
  Config(host: String, port: Int, username: String, password: String)
}

pub type Client {
  Client(config: Config)
}

pub type BitcoinError {
  InvalidConfig
  ConnectionError
  AuthenticationError
  JsonError
  HttpError(Int)
}
