class AddColumnsToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :is_graduate_course, :boolean
    add_column :courses, :prerequisites, :string
    add_column :courses, :full_name, :string
    add_column :courses, :currently_enrolled_students, :string
  end
end
