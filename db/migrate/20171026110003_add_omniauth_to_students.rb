class AddOmniauthToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :provider, :string
    add_column :students, :uid, :integer, :limit => 8
  end
end
