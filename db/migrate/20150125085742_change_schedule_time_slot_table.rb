class ChangeScheduleTimeSlotTable < ActiveRecord::Migration
  def change
  	rename_column :schedules_time_slots, :time_slots_id, :time_slot_id
  	rename_column :schedules_time_slots, :schedules_id, :schedule_id

  	add_index :schedules_time_slots, [:time_slot_id, :schedule_id], unique: true
  end
end
