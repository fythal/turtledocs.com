require 'custom_logger'

class ModelController < ApplicationController
	def view
		@model = Model.where('equipment_id' => params[:equipment_select_id])
		if params[:model_select_id] == 'NULL'
			@model_select = @model.first
		else
			@model_select = Model.where('id' => params[:model_select_id]).first
		end
		@eqp_select_id = params[:equipment_select_id]
		render :partial => 'view_model'
	end

	def edit
		@model = Model.find_by_id(params[:id])
		render :partial => "model_update"
	end

	def update
		model = Model.find(params[:id])
		model.name = params[:name]
		if model.save
			r = {:status => "success", :message => "Model successfully updated.", :equipment_select_id => model.equipment_id, :model_select_id => model.id}
		else
			r = {:status => "error", :message => @select_model.errors.full_messages.join(", ")}
		end
		render :json => {:response => r}
	end

	def add
		@equipment_id = params[:equipment_id]
		render :partial => "model_create"
	end

	def create
		model = Model.create(:name => params[:name], :equipment_id => params[:equipment_id])
		@model = Model.find_by_equipment_id(params[:equipment_id])
		if model.errors.size > 0
			r = {:status => "error", :message => model.errors.full_messages.join(", ")}
		else
			r = {:status => "success", :message => "Model successfully added.", :equipment_select_id => params[:equipment_id], :model_select_id => model.id}
		end
		render :json => {:response => r}
	end

	def remove
		model = Model.find(params[:id])
		equipment_id = model.equipment_id
		model.status = "deleted"
		if model.save
		 	r = {:status => "success", :message => "Model deleted.", :equipment_id => equipment_id}
		else
		 	r = {:status => "error", :message => model.errors.full_messages.join(", ")}
		end
		render :json => {:response => r}
	end
end
