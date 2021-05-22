class User < ApplicationRecord
  has_secure_password

  has_many :notes

  validates_presence_of :email, :name
  validates :email, uniqueness: true,
    format: { with:  URI::MailTo::EMAIL_REGEXP }

end
