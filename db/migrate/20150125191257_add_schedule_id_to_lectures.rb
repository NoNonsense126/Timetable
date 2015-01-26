class AddScheduleIdToLectures < ActiveRecord::Migration
  def change
  	add_column :lectures, :schedule_id, :integer
  end
end
