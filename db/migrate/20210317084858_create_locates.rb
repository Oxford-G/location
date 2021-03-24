class CreateLocates < ActiveRecord::Migration[6.1]
  def change
    create_table :locates do |t|
      t.integer :author_id
      t.string :text

      t.timestamps
    end
    add_index :locates, :author_id
  end
end
