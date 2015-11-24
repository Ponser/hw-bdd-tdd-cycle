class AddDirectorField < ActiveRecord::Migration
  def up
    ActiveRecord::Migration.add_column(:movies, :director, :string, {null: true})
  end
  
  def down
    ActiveRecord::Migration.remove_column(:movies, :director)
  end
end
