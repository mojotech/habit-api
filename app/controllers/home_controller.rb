class HomeController < ApplicationController
  skip_before_filter :authenticate_user_from_token!
  
  def index
  end
end
