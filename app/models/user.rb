class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessor :password_confirmation

  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, length: { minimum: 6 }, on: :create                  
  validate :password_match, on: :create

  before_create :encrypt_password

  private
    def encrypt_password
      self.password_digest = Digest::MD5.hexdigest(self.password)
    end

    def password_match
      if password.to_s != password_confirmation.to_s
        self.errors.add(:password_confirmation, "don't match!")
      end
    end



end
