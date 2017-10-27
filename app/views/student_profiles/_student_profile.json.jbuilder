json.extract! student_profile, :id, :name, :contact, :college, :address, :branch, :current_year, :profile_pic, :gender, :created_at, :updated_at
json.url student_profile_url(student_profile, format: :json)
