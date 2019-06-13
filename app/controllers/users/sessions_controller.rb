class Users::SessionsController < Devise::SessionsController
  def destroy
    current_user.invalidate_session!
    super
  end
end
