class Equipment < ActiveRecord::Base
  attr_accessible :name, :notes, :status
	default_scope :order => 'name ASC'
	has_many :models
end
