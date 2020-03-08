class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates_presence_of :username
         validates_uniqueness_of :username, :uniqueness => true
         validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
         validate :validate_username

         before_validation :sanitize_user_inputs

         def validate_username
          if User.where(email: username).exists?
            errors.add(:username, :invalid)
          end
        end

  has_one_attached :avatar
        
  has_many :listings, dependent: :destroy
  has_many :favorite_listings 
  has_many :favorites, through: :favorite_listings, source: :listing

  has_many :conversations, :foreign_key => :sender_id

  has_many :orders, :foreign_key => :buyer_id

#-----------------------------------------------------------------------
# method is used before validation to only allow specified characters 
# for user input within user model and downcase username
#----------------------------------------------------------------------- 
private
  def sanitize_user_inputs
    self.username = username.downcase
    # gsub not used on username to stop blank usernames reaching database
    self.bio.gsub!(/[^0-9A-Za-z ,.'!"]/, '')
  end

 end
