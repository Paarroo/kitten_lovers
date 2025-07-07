class UserMailer < ApplicationMailer
  default from: ENV['GMAIL_USER'] 

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/login
    mail(to: @user.email, subject: "Bienvenue sur Kitten Lovers 🐱")
  end
end