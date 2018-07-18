class CreateCompleteduas < ActiveRecord::Migration[5.2]
  def change
    create_table :completeduas do |t|
      t.string :name
      t.integer :ua_id
      t.string :lastcompleted

      t.timestamps
    end
  end
end
