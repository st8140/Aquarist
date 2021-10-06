class RemoveColumnToAquaria < ActiveRecord::Migration[6.1]
  def change
    remove_column :aquaria, :title, :string
  end
end
