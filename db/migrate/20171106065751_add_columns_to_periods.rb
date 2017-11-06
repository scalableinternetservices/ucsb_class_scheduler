class AddColumnsToPeriods < ActiveRecord::Migration[5.1]
  def change
    add_column :periods, :currently_enrolled_students, :string
    add_column :periods, :max_class_size, :string
    add_column :periods, :instructor_name, :string
  end
end
