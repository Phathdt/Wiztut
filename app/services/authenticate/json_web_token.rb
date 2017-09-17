class Authenticate::JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
    .first.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  rescue
    nil
  end
end
