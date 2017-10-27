class Students::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def linkedin
        @student = Student.from_omniauth(request.env["omniauth.auth"])
        if @student.persisted?
          sign_in_and_redirect @student, :event => :authentication
          set_flash_message(:notice, :success, :kind => "Linkedin") if is_navigational_format?
        else
          session["devise.linkedin_data"] = request.env["omniauth.auth"]
          redirect_to new_student_profile_url
        end
      end

      def facebook
        @student = Student.from_omniauth(request.env["omniauth.auth"])
        if @student.persisted?
          sign_in_and_redirect @student, :event => :authentication
          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_student_profile_url
        end
      end

    
   def google_oauth2
         # You need to implement the method below in your model (e.g. app/models/user.rb)
         @student = Student.from_omniauth(request.env['omniauth.auth'])

         if @student.persisted?
           flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
           sign_in_and_redirect @student, event: :authentication
         else
           session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
           redirect_to new_student_profile_url, alert: @student.errors.full_messages.join("\n")
         end
     end
   end
