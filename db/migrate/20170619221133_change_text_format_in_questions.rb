class ChangeTextFormatInQuestions < ActiveRecord::Migration[5.1]
    def self.up
        change_column :questions, :text, :text
    end

    def self.down
        change_column :questions, :text, :string
    end
  end
