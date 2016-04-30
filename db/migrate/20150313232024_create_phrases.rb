class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :phrase
      t.string :image_search_phrase1

      t.timestamps null: false
    end
  end
end