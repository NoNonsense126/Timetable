class TimeSlot < ActiveRecord::Base
	has_many :meetings
  has_many :schedules, through: :meetings


	def self.create_time_slots(schedule, options = {period: 60, start_time: 0, end_time: 1440,
																 start_day: 0, end_day: 7})
	  end_time = options[:end_time].to_i
	  start_time = options[:start_time].to_i
	  period = options[:period].to_i
	  start_day = options[:start_day].to_i
	  end_day = options[:end_day].to_i

		periods_per_day = (end_time - start_time)/period
		number_of_days = (end_day - start_day) + 1
		number_of_days.times do |day|
			periods_per_day.times do |num|
				time_slot = TimeSlot.find_or_create_by day: start_day + day,
												start_time: start_time + (num*period),
												end_time: start_time + ((num + 1)*period)
				schedule.time_slots << time_slot
			end
		end
	end
end
