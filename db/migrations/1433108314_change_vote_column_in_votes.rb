class ChangeVoteColumnInVotes < ActiveRecord::Migration
  def change
    rename_column :votes, :vote, :delta
    change_column :votes, :delta, 'integer USING CAST("delta" AS integer)'
  end
end
