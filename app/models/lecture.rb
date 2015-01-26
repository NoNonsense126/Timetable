class Lecture < ActiveRecord::Base
	belongs_to :course
	belongs_to :meeting
	belongs_to :schedule
end