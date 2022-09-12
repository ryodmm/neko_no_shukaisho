class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id #フォローしたユーザ
      t.integer :followed_id #フォローされたユーザ

      t.timestamps
    end
  end
end
