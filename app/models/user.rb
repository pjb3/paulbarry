class User < ApplicationRecord
  has_secure_password validations: false

  def password_matches?(password)
    if password_digest.present?
      authenticate(password)
    else
      false
    end
  end

  def self.verifier
    @verifier ||= ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
  end

  def auth_token
    self.class.verifier.generate(id)
  end

  def self.verify_auth_token(auth_token)
    verifier.verified(auth_token)
  end

  def self.find_by_auth_token(auth_token)
    if id = verify_auth_token(auth_token)
      find_by(id: id)
    end
  end
end
