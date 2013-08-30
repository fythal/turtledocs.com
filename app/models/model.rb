class Model < ActiveRecord::Base
	attr_accessible :equipment_id, :name, :notes, :status
	belongs_to :equipment
	default_scope :order => 'name ASC'
	default_scope where(:status => 'active')
	has_many :documents
	validates :name, :presence => true, :uniqueness => true
end
