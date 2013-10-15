class LogsController < ApplicationController
	def get_recent_docs
		@logs = Log.find(:all,:select => 'id, params', :conditions => {:user_id => current_user.id }, :order => "id DESC" )
		@docs = []
		@logs.each do |log|
			doc = Document.find(:first, :conditions => { :id => log.params })
			next if doc.blank?
			fav = FavoriteDoc.find(:first, :conditions => {:user_id => current_user.id, :document_id => doc.id})
			hash = { :id => doc.id, :name => doc.name, :filepath => doc.filepath, :fav => fav.present?}
			unless @docs.any? {|h| h[:id] == doc.id}	
				@docs.push(hash)
			end
		end
		render :partial => 'recent'
	end
end