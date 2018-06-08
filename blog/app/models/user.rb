class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :firstname, :lastname, :password,:first_name,:email, :password_confirmation
  
has_many :articles

  validates :password, presence: true, length:{minimum:8}
end
