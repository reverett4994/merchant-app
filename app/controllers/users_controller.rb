class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @user_doggies=[]
    @user.items.each do |dog|
      @user_doggies<< dog.id
    end
    @user_doggies.each do |dog|
      if @comments==nil
        @comments=Comment.where('ITEM_ID LIKE ? AND CREATED_AT >= CURDATE()- INTERVAL 1 DAY',dog)
      else
        @comments+=Comment.where('ITEM_ID LIKE ? AND CREATED_AT >= CURDATE()- INTERVAL 1 DAY',dog)
      end
    end
  end

  def search
    @search = params[:search]
    if @search.length < 4
      redirect_to :back
      flash[:alert] = "User Search has to be at least 4 characters long"
    end
    @users=User.where('username LIKE ?','%'+@search+'%')
    if @users.length == 1
      @user=@users[0]
      redirect_to "/users/#{@user.id}"
    end
  end

  def user_to_user
    @from= params[:from]
    @to= params[:to]
    @from_id= params[:from_id]
    @to_email= params[:to_email]
    @message=params[:message]
    UserMailer.user_question(@from,@to,@from_id,@to_email,@message).deliver
    redirect_to page_path('sent_offer')

  end
end
