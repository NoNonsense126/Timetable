class RenameSchedulesTimeSlotToMeetings < ActiveRecord::Migration
  def change
  	rename_table :schedules_time_slots, :meetings
  end
end
