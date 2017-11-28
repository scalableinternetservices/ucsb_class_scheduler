class AlterTypeColumnToIslectureBoolInPeriods < ActiveRecord::Migration[5.1]
  def change
  	remove_column :periods, :type
  	add_column :periods, :is_lecture, :boolean 
  end
end
