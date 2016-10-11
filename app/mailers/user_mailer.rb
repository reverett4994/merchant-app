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



  def offer(item,to,to_username,from_username,offer)
    @item=item
    @to=to
    @to_username=to_username
    @from_username=from_username
    @offer=offer
    mail(to:to,subject:'Offer from a user')
  end

  def messagee(to,to_username,from_username,messagee)
    @to=to
    @to_username=to_username
    @from_username=from_username
    @message=messagee
    mail(to:to,subject:'Message from a user',from:"Dog-Deal.com")
  end
end
