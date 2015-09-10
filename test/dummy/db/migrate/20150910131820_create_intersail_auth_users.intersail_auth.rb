# This migration comes from intersail_auth (originally 20150325091930)
class CreateIntersailAuthUsers < ActiveRecord::Migration
  def change
    create_table :intersail_auth_users do |t|
      t.string :cognome
      t.string :nome
      t.string :username
      t.integer :urrs_id
      t.integer :urrs_unit_id
      t.string :urrs_unit_name
      t.integer :urrs_role_id
      t.string :urrs_role_name
      t.string :z_auth_token
    end
  end
end
