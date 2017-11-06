# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
File.open("data.txt").each do |line|

  parsed_course = JSON.parse(line) #Every line in a the .txt file represents an JSON course object with belonging time objects
  department = parsed_course["department"]
  grading_option = parsed_course["grading_option"]
  name = parsed_course["name"]
  id = parsed_course["id"]
  students_enrolled_max  = parsed_course["max_students"]
  units= parsed_course["units"]
  description= parsed_course["desc"]
  instructor_name= parsed_course["instructors"] #returns instructors separated by comma

  is_graduate_course = parsed_course['is_grad']
  #Course.create( department,id,description,units,grading_option, students_enrolled_max,instructor)
  #students_enrolled_actually= parsed_course["enrolled_students"]
  #prequisites= parsed_course["prequisites"]
  #is_graduate_course not scraping this as of now

  print(department+"\n",grading_option+"\n",name+"\n",id+"\n",description+"\n",instructor_name)
  if instructor_name.include? ","
    instructor_name = instructor_name.split(",")[0]
  end

  if Instructor.exists?(id: instructor_name)
    instructor = Instructor.find(id: instructor_name)
  else
    instructor = Instructor.create(instructor_name)
  end

  course = instructor.courses.create(dept: department, course_no: id, description: description,
                         units: units, grading_opts: grading_option,max_class_size: students_enrolled_max,
                         instructor_id: instructor_name)

  parsed_course["timeslots"].each do |time|
    days_to_repeat = time["days"]
    room = time["location"]
    start_time = time["start_time"]
    end_time = time["end_time"]
    type = time["type"]
    #enrolled_max = time["enrolled_max"]
    #enrolled_count = time["enrolled_count"]
    #instructor = time["instructor"]
    #Course.times.create(...)
    print(days_to_repeat,room,start_time,end_time) #gteiorio  
    instructor.courses.periods.create(start_time: start_time, end_time: end_time, days: days, type: type, room: room)
    break
  end
  break
end