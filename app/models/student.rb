class Student < ApplicationRecord
  has_one :student_profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:linkedin, :facebook, :google_oauth2]

    has_one :profile
    has_many :positions

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |student|
        student.email = auth.info.email
        student.password = Devise.friendly_token[0,20]
        student.name = auth.info.name   # assuming the user model has a name
        student.image = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails, 
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end
    end
  end

    def self.from_omniauth(auth)
       user = User.where(:provider => auth.try(:provider) || auth["provider"], :uid => auth.try(:uid) || auth["uid"]).first
       if user
         return user
       else
         registered_user = User.where(:provider=> auth.try(:provider) || auth["provider"], :uid=> auth.try(:uid) || auth["uid"]).first || User.where(:email=> auth.try(:info).try(:email) || auth["info"]["email"]).first
         if registered_user
           unless registered_user.provider == (auth.try(:provider) || auth["provider"]) && registered_user.uid == (auth.try(:uid) || auth["provider"])
             registered_user.update_attributes(:provider=> auth.try(:provider) || auth["provider"], :uid=> auth.try(:uid) || auth["uid"])
           end
           return registered_user
         else
           user = User.new(:provider => auth.try(:provider) || auth["provider"], :uid => auth.try(:uid) || auth["uid"])
           user.email = auth.try(:info).try(:email) || auth["info"]["email"]
           user.password = Devise.friendly_token[0,20]
           user.save
           # User Postions build
           auth['extra']['raw_info']['positions']['values'].each do |a|
             user.positions.create(position_title: a.try(:title), position_is_current: a.try(:isCurrent), position_company: a.try(:company).try(:name), position_start_date: "#{a.try(:startDate).try(:month)}/#{a.try(:startDate).try(:year)}")
           end if auth.provider == "linkedin"
           # Profile Build for User
           location = auth.info.location

           if auth.provider == "linkedin"
             profile = Profile.new(:name => auth.info.name, :occupation => auth.info.industry, :profile_picture =>  auth.info.image, :country => location[location.length-2..location.length-1], :user_id => user.id, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :headline => auth.info.headline, :location => auth.info.location)
             profile.save
           elsif auth.provider == "facebook"
             
           elsif auth.provider == "google_oauth2"
              
           end
         end
        
       end
     end
   