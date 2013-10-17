class User < ActiveRecord::Base
  # after_create :add_default_role
  rolify
  ROLES = %w[user]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,:roles
  has_many :logs

    private
  def add_default_role
    add_role(:user) if self.roles.blank?
  end
end
