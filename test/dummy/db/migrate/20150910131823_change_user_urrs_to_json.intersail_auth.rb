# This migration comes from intersail_auth (originally 20150707150349)
class ChangeUserUrrsToJson < ActiveRecord::Migration
  def change
    remove_column :intersail_auth_users, :urrs_id
    remove_column :intersail_auth_users, :urrs_unit_id
    remove_column :intersail_auth_users, :urrs_unit_name
    remove_column :intersail_auth_users, :urrs_role_id
    remove_column :intersail_auth_users, :urrs_role_name
    add_column :intersail_auth_users, :urrs, :json, default: {}
  end
end
