class MyMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  
  def user_to_user(from,to)
    @from=from
    @to=to
    mail(to:to,subject:'Question from a user')
  end

end
