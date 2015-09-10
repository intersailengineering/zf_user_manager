# This migration comes from intersail_auth (originally 20150707153220)
class AddApplicationDataToUsers < ActiveRecord::Migration
  def change
    add_column :intersail_auth_users, :application_data, :json, default: {}
  end
end
