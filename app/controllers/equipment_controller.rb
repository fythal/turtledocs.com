require "custom_logger"
require 'json'

class EquipmentController < ApplicationController
	def index
		# if params[:model_id]
		# 	@model_select = Model.find_by_id(params[:model_id]).fifst
		# 	@select_equipment = Equipment.find_by_id(@select_model.equipment_id)
		# elsif params[:equipment_id]
		# 	@select_equipment = Equipment.find_by_id(params[:equipment_id])
		# else
		# 	@select_equipment = Equipment.first
		# end
		@equipment = Equipment.all
		@select_equipment = @equipment.first
		@eqp_select_id = @select_equipment.id
		@model = Model.where(:equipment_id => @eqp_select_id)
		if @model
			@model_select = @model.first
			@docs = Document.where(:model_id => @model_select.id)
		end
		# @model = Model.where('equipment_id' => @select_equipment.id)
		
		# if !@model_select and !@model.blank?
		# 	@model_select = @model.first
		# 	@mdl_select_id = @model.first.id
		# end
		# if @mdl_select_id
		# 	@docs = Document.where(:model_id => @mdl_select_id)
		# end
	end

	def new
		@equipment = Equipment.new
		respond_to do |format|
			format.js
		end
	end

	def create
		equipment = Equipment.create(:name => params[:name])
		@eqp_select_id = equipment.id
		if equipment.errors.size > 0
			r = {:status => "error", :message => equipment.errors.full_messages.join(", ")}
		else
			@equipment = Equipment.select('id, name')
			r = {:status => "success", :message => "Equipment successfully added.", :select_id => @eqp_select_id}
		end
		render :json => {:response => r}
	end

	def add
		render :partial => "equipment_create"
	end

	def edit
		@equipment = Equipment.find_by_id(params[:id])
		render :partial => "equipment_update"
	end

	def update
		equipment = Equipment.find(params[:id])
		equipment.name = params[:name]
		if equipment.save
			r = {:status => "success", :message => "Equipment successfully updated.", :select_id => params[:id], :name => params[:name]}
		else
			r = {:status => "error", :message => equipment.errors.full_messages.join(", ")}
		end
		render :json => {:response => r}
	end

	def get_equipment_list
		@equipment = Equipment.all
		@select_equipment = Equipment.where('id' => params[:id]).first
		@eqp_select_id = params[:id]
		render :partial => "equipment_list"
	end

	def get_model
		@models = Model.where('equipment_id' => params[:id])
		respond_to do |format|
		  format.json { render :json => @models }
		end
	end

	def docs_container
		@select_model = Model.find_by_id(params[:model_id])
		@select_equipment_name = params[:equipment_name]
		@docs = Document.where("model_id" => params[:model_id])
		puts "docs are #{@docs.inspect}"
		render :partial => 'docs_container'
	end

	def remove
		equipment = Equipment.find(params[:id])
		equipment.models.each do |m|
			m.documents.each do |d|
				d.status = 'deleted'
				d.save
			end
			m.status = 'deleted'
			m.save
		end
		equipment.status = "deleted"
		if equipment.save
		 	r = {:status => "success", :message => "Equipment deleted.", :select_id => Equipment.first.id}
		else
		 	r = {:status => "error", :message => equipment.errors.full_messages.join(", ")}
		end
		render :json => {:response => r}
	end

	def search_documents()
		@equipment = Equipment.where("name like ?", "%#{params[:value]}%")
		@model = Model.where("name like ?", "%#{params[:value]}%")
		@docs = Document.where("name like ? and content_type IS NOT NULL", "%#{params[:value]}%")
		render :partial => 'document_search_results'
	end

	def get_search_select()
		render :text => "id is #{params[:id]}"
	end
	
end
