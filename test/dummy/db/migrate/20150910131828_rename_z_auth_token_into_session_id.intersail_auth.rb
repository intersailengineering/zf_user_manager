# This migration comes from intersail_auth (originally 20150709125915)
class RenameZAuthTokenIntoSessionId < ActiveRecord::Migration
  def change
    remove_column :intersail_auth_users, :z_auth_token
    add_column :intersail_auth_users, :session_id, :string
  end
end
