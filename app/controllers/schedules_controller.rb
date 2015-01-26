class SchedulesController < ApplicationController
  def create
  	@schedule = current_user.schedules.build(schedule_params)
  	@schedule.save
  	@user_schedules = current_user.schedules(true)
  	render 'static_pages/home'
  end

  def show
    @schedule = Schedule.find(params[:id])
    @start_time = @schedule.time_slots.pluck(:start_time).min
    @time = @start_time
    @end_time = @schedule.time_slots.pluck(:start_time).max
    one_time_slot = @schedule.time_slots.first
    @period = one_time_slot.end_time - one_time_slot.start_time
    @days = @schedule.time_slots.pluck(:day).uniq
    @result = @schedule.result
  end

  def generate
    @schedule = Schedule.find(params[:id])
    flash[:danger] = "Invalid Lecture List" unless @schedule.generate
    redirect_to schedule_path(@schedule)
  end

  private

  def schedule_params
  	params.require(:schedule).permit(:name)
  end
end
