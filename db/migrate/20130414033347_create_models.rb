class CreateModels < ActiveRecord::Migration
  def change
  	if table_exists?(:models)
  		drop_table :models  		
  	end

    create_table :models do |t|
      	t.integer :equipment_id
      	t.string :name
      	t.text :notes
      	t.string :status, :default => "active"
		t.timestamps
    end
  end
end
