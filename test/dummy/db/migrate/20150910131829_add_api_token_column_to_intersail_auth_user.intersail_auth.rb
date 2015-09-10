# This migration comes from intersail_auth (originally 20150818072559)
class AddApiTokenColumnToIntersailAuthUser < ActiveRecord::Migration
  def change
    add_column :intersail_auth_users, :api_token, :string
  end
end
