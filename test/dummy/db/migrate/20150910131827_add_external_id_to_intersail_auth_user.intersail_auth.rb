# This migration comes from intersail_auth (originally 20150709093517)
class AddExternalIdToIntersailAuthUser < ActiveRecord::Migration
  def change
    add_column :intersail_auth_users, :external_id, :integer
  end
end
