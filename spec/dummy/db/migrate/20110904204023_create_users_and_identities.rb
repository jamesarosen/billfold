require 'active_support/core_ext'

class CreateUsersAndIdentities < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false
      #Any additional fields here
      t.timestamps
    end

    create_table :identities do |t|
      t.integer    :user_id,      :null => false
      t.string     :type,         :null => false
      t.string     :provider,     :null => false
      t.string     :value,        :null => false
      t.text       :data
      t.timestamps
    end
  end

  def self.down
    drop_table :identities, :users
  end
end
