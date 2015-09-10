# This migration comes from intersail_auth (originally 20150325140446)
class AddHashColumnToIntersailAuthUsers < ActiveRecord::Migration
  def change
    add_column :intersail_auth_users, :auth_hash, :string
  end
end
