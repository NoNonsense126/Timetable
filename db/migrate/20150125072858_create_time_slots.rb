class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :day
      t.integer :start_time
      t.integer :end_time
    end
  end
end
