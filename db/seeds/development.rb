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

p departments.first