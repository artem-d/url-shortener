class User
  include Mongoid::Document

  # field :email, type: String
  # field :crypted_password, type: String
  # field :salt, type: String

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

end
