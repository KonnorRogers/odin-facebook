class UsersController < ApplicationController
  def index
    if user_signed_in?
    else
      redirect_to signup_path
    end
  end
end
