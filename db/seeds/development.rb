require "set"
require "json"
require "faker"

def create_instructors(amount)
	unique_instructors = Set.new
	while unique_instructors.length < amount do
		unique_instructors.add("('#{Faker::Company.name.gsub("'", "")}')")
	end

	instructors = unique_instructors.to_a

	instructor_sql = "INSERT INTO instructors (id) VALUES #{instructors.join(", ")}"

	ActiveRecord::Base.connection.execute(instructor_sql)
	return instructors
end

departments = JSON.parse(File.read(File.dirname(__FILE__) +  "/constants/departments.json"))

if Instructor.all.length == 0
	instructors = create_instructors(10000)
	puts 'Created 10000 instructors'
else
	instructors = Instructor.all.map { |instr| instr.id }
end

ActiveRecord::Base.transaction do
	departments.each do |dept|
		10.times do
			p "Starting sql query..."
			course_partition = []
			100000.times do
				units = 2
				grading_opts = "Optional"
				is_graduate_course = true
				max_class_size = 20
				name = Faker::Educator.course

				description = Faker::Company.bs
				course_no = Faker::Lorem.characters(16)
				instructor = instructors.sample
				course_partition.push("('#{dept}','#{units}', '#{grading_opts}', '#{is_graduate_course}', '#{max_class_size}', '#{name}', '#{description}', '#{course_no}', '#{instructor}')")
			end
			course_sql = <<-SQL
				INSERT INTO courses
				(dept, units, grading_opts, is_graduate_course, max_class_size, name, description, course_no, instructor_id)
				VALUES #{course_partition.join(", ")}
				ON CONFLICT DO NOTHING
			SQL
			ActiveRecord::Base.connection.execute(course_sql)
		end
	end
end