class LikesController < ApplicationController
	before_action :require_login, except: [:index]
	before_action :require_correct_user, only: [:create, :destroy]
  def create
  	like = Like.create(like_params)
  	redirect_to "/secrets"
  end

  def destroy
  	Like.find(params[:id]).destroy
    redirect_to "/secrets"
  end

  private

  def like_params
  	params.require(:like).permit(:user_id, :secret_id)
  end
end
