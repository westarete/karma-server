class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :api_key,    :null => false, :unique => true
      t.string :ip_address, :null => false, :unique => true
      t.string :hostname,   :null => false, :unique => true
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
