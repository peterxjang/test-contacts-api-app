class User < ApplicationRecord
  has_many :contacts

  has_secure_password

  def as_json(options={})
    options[:except] = [:password_digest]
    super
  end
end
