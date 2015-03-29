class CreateOauthTokens < ActiveRecord::Migration
  def change
    create_table :oauth_tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.references :user, index: true
      t.boolean :refreshed

      t.timestamps null: false
    end
    add_foreign_key :oauth_tokens, :users
  end
end
