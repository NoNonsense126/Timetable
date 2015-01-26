class Meeting < ActiveRecord::Base
	validates :schedule_id, uniqueness: { scope: :time_slot_id }
  belongs_to :schedule
  belongs_to :time_slot
  has_one :lecture
end
