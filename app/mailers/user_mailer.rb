class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_question.subject
  #
  def user_question(from,to,from_id,to_email,message)
    @greeting = "THIS IS THE VARIABLE IT CHANGES"
    @from=from
    @to=to
    @from_id=from_id
    @to_email=to_email
    @message=message
    mail(to:to_email,subject:'Email from a user')
  end
end
