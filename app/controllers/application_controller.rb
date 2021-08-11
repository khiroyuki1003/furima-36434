class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :user_data_parameter, if: :devise_controller?
  before_action :authenticate_user!, except: [:index, :show]


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def user_data_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :family_name, :first_name_reading, :family_name_reading, :birth_date])
  end
end


