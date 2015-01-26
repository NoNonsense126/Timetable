class TimeSlotsController < ApplicationController
  def create
  	@schedule = Schedule.find(params[:schedules][:schedule_id])
  	TimeSlot.create_time_slots(@schedule, time_slots_params)
  	redirect_to root_url
  end

  private

  def time_slots_params
  	params.require(:time_slots).permit(:period, :start_time, :end_time,
  	 :start_day, :end_day)
  end
end
