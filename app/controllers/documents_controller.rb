class DocumentsController < ApplicationController

	def view
		@docs = Document.where('model_id' => params[:model_id])
		render :partial => 'view_documents', :layout => false, :locals =>{:docs =>@docs}
	end

	def new
		@document = Document.new
		render :partial => 'form_upload'
	end

	def upload
		doc_name = params[:upload][:document].original_filename.to_s
		ext = File.extname(doc_name)
		basename = File.basename("#{Document::UPLOAD_PATH}/#{doc_name}", ext)
		file_name = basename
		cntr = 1
		while File.exist?("#{Document::UPLOAD_PATH}/#{file_name}#{ext}")
			file_name = "#{basename}(#{cntr})"
			cntr += 1
		end
		file_name = "#{file_name}#{ext}"
		path = "#{Document::UPLOAD_PATH}/#{file_name}"
		post = Document.save(params[:upload], file_name)
		
		# if File.exist?("#{Document::UPLOAD_PATH}/#{doc_name}")
		# 	path = "#{Document::UPLOAD_PATH}/#{doc_name}(1)"
		# else
		# 	path = "#{Document::UPLOAD_PATH}/#{doc_name}"
		# end
		doc = Document.create(
			:name => params[:document_name], 
			:model_id => params[:model_id],
			:filepath => path,
			:content_type => params[:upload][:document].content_type.to_s )
    	#render :text => "File has been uploaded successfully #{params[:upload].inspect}"
    	#render :partial => 'view_documents', :content_type => 'text/html'
    	redirect_to :controller => 'equipment', :action => 'index', :model_id => params[:model_id]
	end

	def get_file
		if current_user and current_user.has_role? :user
			doc = Document.where('id' => params[:id]).first
			puts "doc i #{doc.filepath}"
			send_file(doc.filepath, :type => doc.content_type, :disposition => 'inline')
		else
			render :template => "devise/registrations/new", :locals => { :resource => User, :resource_name => :user }
		end
	end

	def edit
		@doc = Document.find_by_id(params[:id])
		render :partial => "document_update"
	end
	
	def update
		doc = Document.find(params[:id])
		doc.name = params[:name]
		if doc.save
			r = {:status => "success", :message => "Document successfully updated.", :model_id => doc.model_id}
		else
			r = {:status => "error", :message => doc.errors.full_messages.join(", ")}
		end
		render :json => {:response => r}
	end

	def remove
		doc = Document.find(params[:id])
		doc.status = "deleted"
		if doc.save
		 	r = {:status => "success", :message => "Document deleted.", :model_id => doc.model_id}
		else
		 	r = {:status => "error", :message => doc.errors.full_messages.join(", ")}
		end
		render :json => {:response => r}
	end

end
