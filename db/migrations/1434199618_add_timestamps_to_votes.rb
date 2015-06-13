class AddTimestampsToVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.timestamps null: false
    end
  end
end
