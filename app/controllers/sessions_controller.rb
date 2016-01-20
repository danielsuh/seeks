class SessionsController < ApplicationController
  def new
  	render 'new'
  end

  def create
  	user = User.find_by(email: params[:Email])
  	if user && user.authenticate(params[:Password])
  		session[:user_id] = user.id
  		redirect_to "/users/#{user.id}"
  	else
  		flash[:wrong] = "Invalid email/password combination"
  		redirect_to "/sessions/new"
  	end
  end

  def destroy
  	session.delete(:user_id)
  	redirect_to "/sessions/new"
  end

end
