class RenameUaIdToClientId < ActiveRecord::Migration[5.2]
  def change
  	rename_column :completeduas, :ua_id, :client_id
  end
end