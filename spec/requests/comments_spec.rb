require 'rails_helper'
require 'factory_bot_rails'
require 'faker'

RSpec.describe CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "POST #create" do
    before do
      @user = FactoryBot.create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
      @post = FactoryBot.create(:post, user_id: @user.id)
    end

    context "with valid attributes" do
      it "creates a new comment"do
        post :create, params: { comment: {body: Faker::Markdown.emphasis}, post_id: @post.id, user_id: @user.id}
        expect(Comment.count).to eq(1)
      end
      it "redirects to the root path with a notice" do
        post :create, params: { comment: {body: Faker::Markdown.emphasis}, post_id: @post.id, user_id: @user.id}
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Комментарий успешно создан")
      end
    end
    context "with invalid attributes" do
      it "do not create a new post" do
        post :create, params: { comment: {body: ""}, post_id: @post.id, user_id: @user.id}
        expect(Comment.count).to eq(0)
      end
      it "redirects to the root path with an alert" do
        post :create, params: { comment: {body: ""}, post_id: @post.id, user_id: @user.id}
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Коментарий недопустим")
      end
    end
  end
end
