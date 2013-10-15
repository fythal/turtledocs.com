class CreateFavoriteDocs < ActiveRecord::Migration
	def change
		create_table :favorite_docs do |t|
			t.integer :user_id
			t.integer :document_id
			t.timestamps
		end
	end
end
