class HelloworldController < ApplicationController

  before_action :authorize!, except: [:index]

  def index
  end

  def accounts
  end

  def logout
    session.delete(:authenticated_user)
    redirect_to root_path
  end
end
