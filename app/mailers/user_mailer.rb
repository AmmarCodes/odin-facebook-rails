class UserMailer < ApplicationMailer
  def welcome_email
    puts params
    @user = params[:user]
    @url = root_url
    mail(to: @user.email, subject: 'Welcome to Odin\'s facebook!')
  end
end
