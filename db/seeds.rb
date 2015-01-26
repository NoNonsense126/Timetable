# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Course.create(name: "Business Communication 1", course_code: "ULB1143")
# Course.create(name: "Business Communication 2", course_code: "ULB1153")
# Course.create(name: "Intensive English", course_code: "ULC0013")


lectures = [["FAR5 A", 2, 1, 1],
["FAR5 K", 1, 1, 1],
["BAM1 2", 1, 2, 1],
["BAM1 A", 1, 1, 1],
["BAM1 L", 2, 1, 1],
["FAR5 K", 1, 1, 1],
["BAS1 2", 1, 2, 1],
["BAA1 A", 1, 1, 1],
["BAZ1 L", 2, 1, 1]]

lectures.each do |l|
	Lecture.create(name: l[0], periods: l[1],
		course_id: l[2], schedule_id: l[3])
end