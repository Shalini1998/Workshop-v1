class AddLatLongToStudentProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :student_profiles, :latitude, :float
    add_column :student_profiles, :longitude, :float
  end
end
