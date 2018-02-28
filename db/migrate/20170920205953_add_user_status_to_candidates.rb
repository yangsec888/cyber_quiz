class AddUserStatusToCandidates < ActiveRecord::Migration[5.1]
  def change
    add_column :candidates, :status, :boolean
  end
end
