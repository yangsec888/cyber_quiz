class CreateQuestions < ActiveRecord::Migration[5.1]
  def self.up
    create_table :questions do |t|
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
