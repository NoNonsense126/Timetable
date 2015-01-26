class CreateSchedulesTimeSlots < ActiveRecord::Migration
  def change
    create_table :schedules_time_slots do |t|
      t.references :schedules, index: true
      t.references :time_slots, index: true

      t.timestamps null: false
    end
  end
end
