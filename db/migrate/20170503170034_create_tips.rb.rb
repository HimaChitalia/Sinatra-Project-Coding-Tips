class CreateTips < ActiveRecord::Migration[5.1]
  def change
    create_table :tips do |t|
      t.integer :user_id
      t.integer :language_id
      t.string :content
      t.timestamps
    end
  end
end
