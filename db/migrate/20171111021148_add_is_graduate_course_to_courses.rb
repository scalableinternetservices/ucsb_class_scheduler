class AddIsGraduateCourseToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :is_graduate_course, :boolean
  end
end
