class UserMailer < ActionMailer::Base
  default from: "Joe Buhlig <joe@joebuhlig.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "Excited for #WorkingWithIdeas to launch! Get $12 off just for joining the email list."

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
