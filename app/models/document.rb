class Document < ActiveRecord::Base
	attr_accessible :name, :notes, :status, :model_id, :filepath, :content_type
	belongs_to :models
	default_scope :order => 'name ASC'
	default_scope where(:status => 'active')
	validates :name, :presence => true, :uniqueness => true
	UPLOAD_PATH = '/var/spool/turtledocs.com/documents/model_documents'
	def self.save(upload, file_name)
		name =  upload['document'].original_filename
		directory = UPLOAD_PATH
		# create the file path
		path = File.join(directory, file_name)
		# write the file
		File.open(path, "wb") { |f| f.write(upload['document'].read) }
	end
end
