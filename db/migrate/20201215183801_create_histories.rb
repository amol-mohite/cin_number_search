class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.string :cin_number
      t.integer :user_id
      t.datetime :searched_at
      t.timestamps
    end
  end
end
