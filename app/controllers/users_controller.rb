class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def user_to_user
    @from= params[:from]
    @to= params[:to]
    @from_id= params[:from_id]
    @to_email= params[:to_email]
    @message=params[:message]
    UserMailer.user_question(@from,@to,@from_id,@to_email,@message).deliver
    redirect_to(:back)
    flash[:notice] = "Your Email has been sent to #{@to}"

  end
end
