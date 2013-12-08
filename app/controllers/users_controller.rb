class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user]) 
    if @user.save
      sign_in @user
      flash[:success] = "Welcome, #{@user.first_name} #{@user.last_name}!"
      redirect_to @user
    else
      render 'new'
    end
  end

 private

    def user_params
#      params.require(:user).permit(:name, :email, :password,
#                                   :password_confirmation)
 #     params.require(:user).permit(:first_name, :last_name, :nick_name)
#                                   :password_confirmation)
    end


end
