class RemoveMeetingIdFromCourses < ActiveRecord::Migration
  def up
  	remove_column :courses, :meeting_id
  	add_column :courses, :course_code, :string
  end

  def down
  	add_column :courses, :meeting_id, :integer
  	remove_column :courses, :course_code
  end
end
