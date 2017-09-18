class Authenticate::JsonWebToken
  EXPIRY_TIME = 1.month.to_i
  def self.encode(payload)
    payload[:exp] = Time.now.to_i + EXPIRY_TIME
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
    .first.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  rescue
    nil
  end
end
