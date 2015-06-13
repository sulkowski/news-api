class AddTimestampsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.timestamps null: false
    end
  end
end
