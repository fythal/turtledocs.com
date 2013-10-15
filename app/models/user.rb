class User < ActiveRecord::Base
  after_create :assign_role_after_sign_up
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :logs

  protected  
    def assign_role_after_sign_up 
      user = User.new
      puts "------------------ #{user.inspect}" 
    end
end
