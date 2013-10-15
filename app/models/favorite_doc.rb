class FavoriteDoc < ActiveRecord::Base
  attr_accessible :user_id, :document_id
  validates :user_id, :uniqueness => { :scope => :document_id }
end
