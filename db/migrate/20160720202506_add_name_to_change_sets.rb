class AddNameToChangeSets < ActiveRecord::Migration
  def change
    add_column :change_sets, :name, :string
  end
end
