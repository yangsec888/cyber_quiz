class CreateReporters < ActiveRecord::Migration
  def change
    create_table :reporters do |t|
	  t.string :candidate
	  t.string :candidate_email
	  t.string :quiz_category
	  t.string :quiz_eventid
	  t.float :quiz_score
      t.timestamps null: false
    end
  end
end
