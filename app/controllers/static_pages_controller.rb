class StaticPagesController < ApplicationController
  def home
  	@schedule = current_user.schedules.build
  	@user_schedules = current_user.schedules(true)
  end
end
