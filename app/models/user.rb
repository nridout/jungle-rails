class User < ActiveRecord::Base

  before_save { email.downcase! }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :email,  presence: true, length: { maximum: 50 },
                      format: { with: /@/ },
                      uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :reviews

end
