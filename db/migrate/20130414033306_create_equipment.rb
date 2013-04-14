class CreateEquipment < ActiveRecord::Migration
  def up
    if table_exists?(:equipment)
      drop_table :equipment 
    end

    if table_exists?(:equipments)
      drop_table :equipments 
    end
  	create_table :equipment do |t|
    	t.string :name
    	t.text :notes
    	t.string  :status, :default => "active"
    	t.timestamps
    end
  end


  def down
  end
end
