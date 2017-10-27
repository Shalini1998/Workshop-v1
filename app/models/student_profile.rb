class StudentProfile < ApplicationRecord
  belongs_to :student, optional: true
  geocoded_by :address   
  after_validation :geocode
  mount_uploader :profile_pic, ProfilePicUploader
  
end
