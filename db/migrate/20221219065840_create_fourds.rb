class CreateFourds < ActiveRecord::Migration[7.0]
  def change
    create_table :fourds do |t|
      t.string :drawnumber
      t.date :drawdate
      t.string :first
      t.string :second
      t.string :third
      t.string :starter
      t.string :consolation

      t.timestamps
    end
  end
end
