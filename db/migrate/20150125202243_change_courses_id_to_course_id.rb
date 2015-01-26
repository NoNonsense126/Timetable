class ChangeCoursesIdToCourseId < ActiveRecord::Migration
  def change
  	rename_column :lectures, :courses_id, :course_id
  end
end
