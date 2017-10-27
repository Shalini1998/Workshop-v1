class AddEmailToStudentProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :student_profiles, :email, :string
  end
end
