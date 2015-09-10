# This migration comes from intersail_auth (originally 20150909122730)
class RemoveApiTokenColumnFromIntersailAuthUser < ActiveRecord::Migration
  def change
    remove_column :intersail_auth_users, :api_token
  end
end
