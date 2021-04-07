class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def welcome_email(destino, code)
    @code = code
    mail(to: destino, subject: 'Welcome to My Awesome Site')
  end
end
