class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      #サーバーのusersのidとtweetsのidと連携し、そこにtext（コメント）を投稿するため下記内容になっている
      t.integer :user_id
      t.integer :tweet_id
      t.text :text
      t.timestamps
    end
  end
end
