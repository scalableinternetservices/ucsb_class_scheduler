class AddNameToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :name, :string
  end
end
