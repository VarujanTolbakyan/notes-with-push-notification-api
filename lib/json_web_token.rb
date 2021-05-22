class JsonWebToken
  # secret to encode and decode token
  SECRET_KEY = Rails.application.secrets.secret_key_base

  # Encodes and signs the payload the user email using our app's secret key
  # The result also includes the expiration date.
  def self.encode(payload, exp = 1.day.from_now.to_i)
    payload['exp'] = exp
    JWT.encode(payload, SECRET_KEY)
  end

  # Decode the JWT to get the user email
  def self.decode(token)
    JWT.decode(token, SECRET_KEY)
  end

  # Validates the payload hash for expiration and meta claims
  def self.valid_payload(payload)
    return expired(payload) ? false : true
  end

  # Validates if the token is expired by exp parameter
  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end