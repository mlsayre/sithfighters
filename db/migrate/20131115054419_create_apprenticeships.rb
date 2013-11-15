class CreateApprenticeships < ActiveRecord::Migration
  def change
    create_table :apprenticeships do |t|
      t.integer :jedi_id
      t.integer :padawan_id

      t.timestamps
    end
  end
end
