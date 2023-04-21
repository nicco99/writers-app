class CreateWriters < ActiveRecord::Migration[7.0]
  def change
    create_table :writers do |t|
      t.string "first_name"
      t.string "last_name"
      t.string "username"
      t.string "email"
      t.integer "p_number"
      t.string "gender"
      t.string "password_digest"
      t.timestamps
    end
  end
end
