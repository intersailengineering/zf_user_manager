# This migration comes from intersail_auth (originally 20150708150648)
class AddAdminColumnToIntersailUser < ActiveRecord::Migration
  def change
    add_column :intersail_auth_users, :admin, :boolean, :default => false
  end
end
