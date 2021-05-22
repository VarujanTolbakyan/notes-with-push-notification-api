class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :name
  validates :email, uniqueness: true,
    format: { with:  URI::MailTo::EMAIL_REGEXP }

end
