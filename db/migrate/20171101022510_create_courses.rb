class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :dept
      t.string :course_no
      t.text :description
      t.integer :units
      t.string :grading_opts
      t.integer :max_class_size
      t.references 'instructor', foreign_key: true, type: :string

      t.index [:instructor_id, :dept, :course_no], unique: true
    end
  end
end
