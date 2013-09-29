class AddDocs < ActiveRecord::Migration
  def up
  	add_column	:documents,	:file_size,		:integer
  end

  def down
  	remove_column	:documents,	:file_size,		:integer
  end
end
