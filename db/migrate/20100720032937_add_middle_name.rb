class AddMiddleName < ActiveRecord::Migration
  def self.up
    add_column :People, :middle_name, :string
  end

  def self.down
    remove_column :People, :middle_name
  end
end
