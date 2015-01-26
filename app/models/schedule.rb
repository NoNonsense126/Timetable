class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :meetings
  has_many :time_slots, through: :meetings
  has_many :lectures



  def generate
    @time_count = time_slots.count
  	array = Array.new(lecture_days.size){Array.new(periods_per_day, 0)}
  	lectures_by_priority = lectures.sort{|x,y| y.periods <=> x.periods}
    return false unless check_valid_list? (lectures_by_priority)
   	table = recursive_insert(array, lectures_by_priority, choice = 0)
   	update(result: (table.map {|row| row.map{ |ele| ele.try(:id)}}))
  end

  def check_valid_list?(lecture_list)
    check_no_overlapping_courses(lecture_list) && check_total_period_within_time(lecture_list)
  end

  def check_total_period_within_time(lecture_list)
    (lecture_days.size * periods_per_day)/lecture_list.map(&:periods).inject{ |sum, x| sum + x }
  end

  def check_no_overlapping_courses(lecture_list)
    frequency = score(lecture_list.map { |x| x.course.id })
    if frequency.max_by{|k,v| v}[1] > lecture_days.size
      return false
    else
      return true
    end
  end

  def score( array )
    array.each_with_object(Hash.new(0)){|key,hash| hash[key] += 1}
  end

  # def recursive_insert(array, lecture_list, choice = 0)
  # 	current_array = Marshal.load(Marshal.dump(array))


		# if lecture_list == []
		# 	return array


		# elsif choice > time_slots.count
  #     return "try next"


		# elsif updated_array = insert_lecture(current_array, lecture_list[0], choice)
		# 	updated_array = recursive_insert(updated_array, lecture_list[1..-1])
		

  #   else
  #     p "failed"
		# 	recursive_insert(current_array, lecture_list, choice + 1)
		# end
		# updated_array
  # end
  def recursive_insert(array, lecture_list, choice = 0)
    current_array = Marshal.load(Marshal.dump(array))
    p "#{array.map {|row| row.map{ |ele| ele.try(:id)}}}"
    if lecture_list == []
      return array
    end

    result = false
    while choice < @time_count && result == false
      new_array = Marshal.load(Marshal.dump(array))
      if updated_array = insert_lecture(new_array, lecture_list[0], choice)
        p "Scope #{lecture_list[0]}"
       result = recursive_insert(updated_array, lecture_list[1..-1], 0)
      end
      choice += 1
    end
    result
  end

  # def recursive_insert(array, lecture_list, choice = 0)
  #   current_array = Marshal.load(Marshal.dump(array))
  #   p "scope #{lecture_list[0].id}"
  #   #try to put in first_element

  #   if lecture_list == []
  #     return current_array
  #   elsif updated_array = insert_lecture(current_array, lecture_list[0], choice)
  #     p 'inserted'
  #     if recursive_insert(updated_array, lecture_list[1..-1], 0)
  #       return array
  #     else
  #       return recursive_insert(current_array, lecture_list, 1)
  #     end
  #   else
  #     result = false
  #     until choice > time_slots.count || result
  #       p "itereating through it #{choice}"
  #       result = recursive_insert(array, lecture_list, choice += 1)
  #       choice += 1
  #     end
  #     if choice > time_slots.count 
  #       return false
  #     else
  #       return result
  #     end
  #   end

  # end



  def insert_lecture(array, lecture, choice)
  	count = 0
  	lecture_length = lecture.periods
  	array.each do |row|
  		if lecture_course_same_day(row, lecture)
  			next
  		else
  			#check whether lecture fits
  			row.each_with_index do |ele, index|
  				if ele == 0 && row.length >= lecture_length + index
  					if count == choice
	  					lecture_length.times do |x|
		  					row[index+x] = lecture
		  				end
		  				return array
		  			else
		  				count += 1
		  			end
  				end
  			end
  		end
  	end
  	return false
  end

  def lecture_course_same_day(row, lecture)
  	row.each do |ele|
  		if ele.kind_of? Lecture
  			return true if lecture.course == ele.course
  		end
  	end
  	return false
  end

  def lecture_days
  	time_slots.pluck(:day).uniq
  end

  def periods_per_day
  	time_slots.count/lecture_days.size
  end
end
