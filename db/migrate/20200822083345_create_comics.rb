class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :title
      t.string :title_kana
      t.string :author
      t.string :publisher
      t.text :story
      t.integer :back_number
      t.integer :user_id

      t.timestamps
    end
  end
end
