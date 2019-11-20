class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
	       :recoverable, :rememberable, :validatable,
	       :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  
  validates :handle, length: {in: 5..20}, presence: true, uniqueness: true, allow_blank: false

  def valid_password?(password)
    valid = super
    if valid && !encrypted_password.start_with?("$argon2")
      self.password = password
      save(validate: false)
    end
    valid
  end
end
