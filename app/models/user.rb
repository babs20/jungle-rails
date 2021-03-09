class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, uniqueness: { case_sensitive: false }, presence: true

  def self.authenticate_with_credentials(email, password)
    formatted_email = email.strip.downcase

    user = User.where('LOWER(email) = ?', [formatted_email])[0]
    user && user.authenticate(password) ? user : nil
  end
end
