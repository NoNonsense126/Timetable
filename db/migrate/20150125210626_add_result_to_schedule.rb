class AddResultToSchedule < ActiveRecord::Migration
  def change
  	add_column :schedules, :result, :integer, array: true
  end
end
