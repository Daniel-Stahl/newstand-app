class UsersController < ApplicationController
  before_action :logged_in, except: [:show, :update]
  def new
    @user = User.new
  end
  
  def create 
  @user = User.new(user_params) 
  	if @user.save 
    	session[:user_id] = @user.id 
    	redirect_to '/' 
  	else 
    	redirect_to '/signup' 
  	end 
	end
  
  def show
    @user = User.find_by(params[:id])
  end
  
  def update
    @user = User.find_by(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      flash[:success] = "Succesfully updated!"
    	redirect_to user_path
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
