class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authorize!
    redirect_to '/saml/init' unless authorized?
  end

  helper_method :authorized?

  def authorized?
    session[:authenticated_user].present?
  end
end
