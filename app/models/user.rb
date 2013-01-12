class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  def full_name
    [first_name, last_name].compact.join(" ")
  end
end
