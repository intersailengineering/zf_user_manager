# This migration comes from intersail_auth (originally 20150326165104)
class AddTimestampsToIntersailAuthUsers < ActiveRecord::Migration
  def change
    add_timestamps(:intersail_auth_users)
  end
end
