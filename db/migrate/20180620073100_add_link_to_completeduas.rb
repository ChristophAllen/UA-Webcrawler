class AddLinkToCompleteduas < ActiveRecord::Migration[5.2]
  def change
    add_column :completeduas, :link, :string
  end
end
