class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors, id: false do |t|
      t.string :id, primary_key: true
      t.string :rmp_url
    end
  end
end
