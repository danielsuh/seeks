require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before do 
    @user = create_user
    @secret = @user.secrets.create(content: "secret")
    @like = Like.create(user_id: @user, secret_id: @secret)
  end

  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot like" do
      post :create
      expect(response).to redirect_to('/sessions/new')
    end

    it "cannot destroy" do 
      delete :destroy, id: @user
      expect(response).to redirect_to('/sessions/new')
    end
  end
  describe "when signed in as the wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user
    end

    it "cannot access destroy" do
      delete :destroy, id: @like
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
  end

end
