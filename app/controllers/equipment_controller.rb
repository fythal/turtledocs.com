require "custom_logger"
require 'json'

class EquipmentController < ApplicationController
	def index
		@equipment = Equipment.all
		@select_equipment = Equipment.first
		@select_id = @select_equipment.id
		@model = Model.where('equipment_id' => @select_equipment.id)
	end

	def new
		@equipment = Equipment.new
		respond_to do |format|
			format.js
		end
	end

	def create
		equipment = Equipment.create(:name => params[:name])
		@select_id = equipment.id
		if equipment.errors.size > 0
			r = {:status => "error", :message => equipment.errors.full_messages.join(", ")}
		else
			@equipment = Equipment.select('id, name')
			r = {:status => "success", :select_id => @select_id}
		end
		render :json => {:response => r}
	end

	def add
		render :partial => "equipment_form"
	end

	def update
	end

	def get_equipment_list
		@equipment = Equipment.all
		@select_equipment = Equipment.where('id' => params[:id]).first
		@select_id = params[:id]
		render :partial => "equipment_list"
	end

	def get_model
		@models = Model.where('equipment_id' => params[:id])
		respond_to do |format|
		  format.json { render :json => @models }
		end
	end
end
