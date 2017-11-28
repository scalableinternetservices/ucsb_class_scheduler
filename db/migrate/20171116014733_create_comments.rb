class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
		t.text :content, null: false, default: ""
		t.references 'user', foreign_key: true, null: false
		t.references 'course', foreign_key: true, null: false

		t.timestamps
    end
  end
end
