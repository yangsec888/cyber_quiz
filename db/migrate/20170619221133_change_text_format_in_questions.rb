class ChangeTextFormatInQuestions < ActiveRecord::Migration
    def self.up
        change_column :questions, :text, :text
    end

    def self.down
        change_column :questions, :text, :string
    end
  end
