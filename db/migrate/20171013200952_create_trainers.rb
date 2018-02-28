class CreateTrainers < ActiveRecord::Migration[5.1]
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :description
      t.string :logo

      t.timestamps null: false
    end
  end
end
