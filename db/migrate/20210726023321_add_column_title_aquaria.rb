class AddColumnTitleAquaria < ActiveRecord::Migration[6.0]
  def change
    add_column :aquaria, :title, :string
  end
end
