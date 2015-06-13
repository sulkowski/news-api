class AddTimestampsToStories < ActiveRecord::Migration
  def change
    change_table :stories do |t|
      t.timestamps null: false
    end
  end
end
