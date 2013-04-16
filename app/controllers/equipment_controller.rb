class EquipmentController < ApplicationController
	def index
		@equipment = Equipment.all
		@equipment_first = Equipment.first
		@model = Model.where('equipment_id' => @equipment_first.id)
	end

	def new
		@equipment = Equipment.new
		render :template => "new_equipment"
	end

	def create
		@equipment = Equipment.new(params[:equipment])
		if @equipment.save
			#do something if successful
		else
			
		end
	end

	def add
	end

	def update
	end

	def get_model
		@models = Model.where('equipment_id' => params[:id])
		respond_to do |format|
		  format.json { render :json => @models }
		end
	end
end
