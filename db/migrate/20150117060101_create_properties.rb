class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :width
      t.string :length
      t.string :province

      t.timestamps
    end
  end
end
