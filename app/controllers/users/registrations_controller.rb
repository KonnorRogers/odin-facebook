class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    # Sends my own custom email
    UserMailer.welcome_email(self).deliver_later
  end
end
