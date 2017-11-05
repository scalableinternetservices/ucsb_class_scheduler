class CreatePeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :periods, id: false do |t|
      t.time :start_time
      t.time :end_time
      t.string :days
      t.string :type
      t.string :location

      t.references :course
    end
  end
end
