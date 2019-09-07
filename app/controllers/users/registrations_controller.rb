class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    Devise::Mailer.confirmation_instructions(@user).deliver_later
  end
end
