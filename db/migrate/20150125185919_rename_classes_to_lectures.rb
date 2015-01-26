class RenameClassesToLectures < ActiveRecord::Migration
  def change
  	rename_table :classes, :lectures
  	add_column :lectures, :meeting_id, :integer
  end
end
