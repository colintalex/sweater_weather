class User < ApplicationRecord
before_create :generate_api_key

validates :email, presence: true, uniqueness: true
validates :password, presence: true
validates :password, confirmation: { case_sensitive: true }
has_secure_password

  def generate_api_key
    self.api_key = SecureRandom.base58(24)
  end
end
