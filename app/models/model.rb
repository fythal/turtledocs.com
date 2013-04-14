class Model < ActiveRecord::Base
  attr_accessible :equipment_id, :name, :notes, :status
  belongs_to :equipment
end
