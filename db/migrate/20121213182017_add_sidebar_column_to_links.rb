class AddSidebarColumnToLinks < ActiveRecord::Migration
  def change
    add_column :links, :sidebar, :boolean, :default => false
  end
end
