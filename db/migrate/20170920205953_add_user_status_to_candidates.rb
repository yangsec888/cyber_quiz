class AddUserStatusToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :status, :boolean
  end
end
