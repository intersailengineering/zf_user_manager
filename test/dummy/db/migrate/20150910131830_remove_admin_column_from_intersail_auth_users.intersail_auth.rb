# This migration comes from intersail_auth (originally 20150902140724)
class RemoveAdminColumnFromIntersailAuthUsers < ActiveRecord::Migration
  def change
    remove_column :intersail_auth_users, :admin
  end
end
