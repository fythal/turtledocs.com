class CreateDocumentTable < ActiveRecord::Migration
  def up
    if table_exists?(:documents)
      drop_table :documents 
    end

    create_table :documents do |t|
    	t.string :model_id
    	t.string :name
    	t.string :url
    	t.string :filepath
      t.string :content_type
      t.integer :file_size
    	t.text :notes
    	t.string  :status, :default => "active"
    	t.timestamps
    end
  end


  def down
  end
end
