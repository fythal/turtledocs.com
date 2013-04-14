namespace :db do
	desc "Fill database with sample data"
  	task populate_model: :environment do
		eq = Equipment.all
		eq.each do |e|
			25.times do
				name = e.name[0..3] + rand(100000 - 999999).to_s
			    Model.create!(equipment_id: e.id, name: name)
			end
	    end
	end
end