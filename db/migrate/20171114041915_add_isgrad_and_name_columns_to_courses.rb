class AddIsgradAndNameColumnsToCourses < ActiveRecord::Migration[5.1]
  def change
  	add_column :courses, :is_graduate_course, :boolean
  	add_column :courses, :name, :string
  end
end
