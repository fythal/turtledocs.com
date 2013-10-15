class Log < ActiveRecord::Base
  attr_accessible :user_id, :controller, :action, :params
  belongs_to :user
end
