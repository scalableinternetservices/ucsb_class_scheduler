require 'json'
File.open("db/schools_data.json").each do |line|
  parsed_course = JSON.parse(line)
  # Every line in a the .txt file represents an JSON course object with
  # belonging time objects
  department = parsed_course["department"]
  grading_option = parsed_course["grading_option"]
  name = parsed_course["name"]
  id = parsed_course["id"]
  students_enrolled_max  = parsed_course["max_students"]
  units= parsed_course["units"]
  description= parsed_course["desc"]
  instructor_name= parsed_course["instructors"]
  # returns instructors separated by comma
  is_graduate_course = parsed_course['is_grad']
  # Unused data: students_enrolled_actually, prerequisites
  if instructor_name.include? ","
    instructor_name = instructor_name.split(",")[0]
  end
  instructor = Instructor.where(id: instructor_name)
                         .first_or_create(rmp_url: 'example.com')
  course = instructor.courses.where(dept: department, course_no: id)
                     .first_or_create(
                         name: name,
                         description: description,
                         units:              units,
                         grading_opts:       grading_option,
                         max_class_size:     students_enrolled_max,
                         instructor_id:      instructor_name,
                         is_graduate_course: is_graduate_course
                     )
  parsed_course["timeslots"].each do |time|
    days = time["days"]
    room = time["location"]
    start_time = time["start_time"]
    end_time = time["end_time"]
    type = time["type"]
    # Unused data: enrolled_max, enrolled_count, instructor
    if start_time == ""
      start_time = "00:00pm"
    end
    if end_time == ""
      end_time = "00:00pm"
    end
    course.periods.where(
        start_time: start_time,
        end_time: end_time,
        days: days,
        period_type: type,
        location: room
    ).first_or_create()
  end
end
puts 'Database now has ' + Course.all.count.to_s + ' courses'