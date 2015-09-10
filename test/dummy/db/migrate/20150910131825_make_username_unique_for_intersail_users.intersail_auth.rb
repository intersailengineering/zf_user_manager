# This migration comes from intersail_auth (originally 20150708073735)
class MakeUsernameUniqueForIntersailUsers < ActiveRecord::Migration
  def change
    add_index :intersail_auth_users, :username, :unique => true
  end
end
