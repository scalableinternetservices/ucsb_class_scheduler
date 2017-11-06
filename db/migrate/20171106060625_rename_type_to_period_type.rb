class RenameTypeToPeriodType < ActiveRecord::Migration[5.1]
  def change
    change_table :periods do |t|
      t.rename :type, :period_type
    end
  end
end
