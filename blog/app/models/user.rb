class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :password
has_many :articles

  validates :password, presence: true, length:{minimum:8}
  validates :email, presence: true
end
