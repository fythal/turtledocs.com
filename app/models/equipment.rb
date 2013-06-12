class Equipment < ActiveRecord::Base
  	attr_accessible :name, :notes, :status
	default_scope :order => 'name ASC'
	default_scope where(:status => 'active')
	has_many :models
	validates :name, :presence => true, :uniqueness => true
	

end
