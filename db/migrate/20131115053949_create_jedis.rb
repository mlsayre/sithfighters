class CreateJedis < ActiveRecord::Migration
  def change
    create_table :jedis do |t|
      t.string :name

      t.timestamps
    end
  end
end
