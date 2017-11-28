require 'json'

File.open("db/schools_data.json").each do |line|
  parsed_course = JSON.parse(line)
  department            = parsed_course["department"]
  grading_option        = parsed_course["grading_option"]
  name                  = parsed_course["name"]
  id                    = parsed_course["id"]
  students_enrolled_max = parsed_course["max_students"]
  units                 = parsed_course["units"]
  description           = parsed_course["desc"]
  is_graduate_course    = parsed_course['is_grad']
  instructor_name       = parsed_course["instructors"].split(",")[0]

  instructor = Instructor.find_or_create_by(id: instructor_name)
  course = instructor.courses.find_or_create_by(
                            dept:               department,
                            course_no:          id,
                            name:               name,
                            description:        description,
                            units:              units,
                            grading_opts:       grading_option,
                            max_class_size:     students_enrolled_max,
                            instructor_id:      instructor_name,
                            is_graduate_course: is_graduate_course
                         )

  parsed_course["timeslots"].each do |time|
    days        = time["days"]
    room        = time["location"]
    start_time  = time["start_time"]
    end_time    = time["end_time"]
    is_lecture  = time["type"] == "Lecture"

    # Unused data: enrolled_max, enrolled_count, instructor
    start_time = nil if start_time.empty?
    end_time = nil if end_time.empty?

    course.periods
          .where(
              start_time:   start_time,
              end_time:     end_time,
              days:         days,
              is_lecture:   is_lecture,
              location:     room
          ).create()
  end

end

puts 'Database now has ' + Course.all.count.to_s + ' courses'