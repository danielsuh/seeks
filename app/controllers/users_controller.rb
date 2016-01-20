class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def new
  	render 'new'
  end

  def create
  	user = User.new(name: params[:Name], email: params[:Email], password: params[:Password], password_confirmation: params[:Password_Confirmation])
		if user.save
			flash[:success] = "Great job"
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else 
			flash[:errors] = user.errors.full_messages
			redirect_to :back
		end
  end

  def show
  	@user = User.find(params[:id])
  	@secrets = @user.secrets
  	render 'show'
  end

  def edit
  	@user = User.find(params[:id])
  	render 'edit'
  end

  def update
  	u = User.find(params[:id])
  	u.update(name: params[:Name], email: params[:Email])
  	redirect_to "/users/#{u.id}"
  end

  def destroy
  	u = User.find(params[:id])
  	session.delete(:user_id)
  	u.delete
  	redirect_to "/sessions/new"
  end

  def cat
    render 'cat'
  end

  private
  # def user_params
  # 	params.require(:user).permit(:Name, :Email, :Password, :Password_Confirmation)
  # end
end
