class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   validates :first_name, :last_name, :phone, presence: true

   PHONE_REGEX = /\A[0-9]*\Z/

   validates_format_of :phone, with: PHONE_REGEX
   validates :phone, length: {is: 10}

   def full_name
   	last_name.upcase + ", " + first_name.upcase
   end
end
