class Log < ActiveRecord::Migration
	def change
		create_table(:logs) do |t|
			t.integer :user_id
			t.string :controller
			t.string :action
			t.string :params
			t.timestamps
		end

	end
end
