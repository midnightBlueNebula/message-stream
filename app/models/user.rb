class User < ApplicationRecord
    attr_accessor :remember_token

    has_many :messages   , dependent: :destroy
    has_many :likes      , dependent: :destroy
    has_many :dislikes   , dependent: :destroy

    before_create { email.downcase! }
    has_secure_password

    validates :name, presence: true, length: { maximum: 50 }, 
                                    uniqueness: { case_sensitive: true }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, 
                                        format: { with: VALID_EMAIL_REGEX },
                                        length: { maximum: 200 }

    validates :password, presence: true, length: { minimum: 6, maximum: 100 }

    class << self

        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? 
                        BCrypt::Engine::MIN_COST : 
                        BCrypt::Engine.cost                                                          
                        BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end

    end

    def remember
        @remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(@remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
end
