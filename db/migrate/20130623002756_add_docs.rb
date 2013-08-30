class AddDocs < ActiveRecord::Migration
  def up
  	add_column	:documents,	:content_type,	:string
  	add_column	:documents,	:file_size,		:integer
  end

  def down
  	remove_column	:documents,	:content_type,	:string
  	remove_column	:documents,	:file_size,		:integer
  end
end
