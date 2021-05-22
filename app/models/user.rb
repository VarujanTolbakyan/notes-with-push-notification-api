class User < ApplicationRecord
  has_secure_password

  has_many :notes, dependent: :destroy

  validates_presence_of :email, :name
  validates :email, uniqueness: true,
    format: { with:  URI::MailTo::EMAIL_REGEXP }

end
