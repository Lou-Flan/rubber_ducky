class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates_presence_of :username
         validates_uniqueness_of :username, :uniqueness => true
         validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
         validate :validate_username

         def validate_username
          if User.where(email: username).exists?
            errors.add(:username, :invalid)
          end
        end
        
 end
