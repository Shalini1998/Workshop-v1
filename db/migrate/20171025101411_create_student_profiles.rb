class CreateStudentProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :student_profiles do |t|
      t.string :name
      t.string :contact
      t.string :college
      t.string :address
      t.string :branch
      t.string :current_year
      t.string :profile_pic
      t.string :gender

      t.timestamps
    end
  end
end
