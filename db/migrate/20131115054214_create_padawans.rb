class CreatePadawans < ActiveRecord::Migration
  def change
    create_table :padawans do |t|
      t.string :name

      t.timestamps
    end
  end
end
