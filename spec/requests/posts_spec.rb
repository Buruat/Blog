require 'rails_helper'
require 'factory_bot_rails'
require 'faker'
RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  user = FactoryBot.create(:user)
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end


  describe "GET #index" do

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all posts to @posts" do
      user1 = create(:user)
      user2 = create(:user)
      post1 = create(:post,user_id: user1.id)
      post2 = create(:post,user_id: user2.id)
      get :index
      expect(assigns(:posts)).to eq([post1,post2])
    end
  end

  describe "GET #show" do
    let(:post){create(:post,user_id: user.id)}
    it "returns a success response" do
      get :show, params: { id: post.id }
      expect(response).to be_successful
    end
    it "assigns the requested post to @post" do
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new post"do
        post :create, params: { post: FactoryBot.attributes_for(:post)}
        expect(Post.count).to eq(1)
      end
      it "redirects to the root path" do
        post :create, params: { post: FactoryBot.attributes_for(:post)}
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Пост успешно создан")
      end
    end
    context "with invalid attributes" do
      it "do not create a new post" do
        post :create, params: { post: FactoryBot.attributes_for(:post, body: "")}
        expect(Post.count).to eq(0)
      end
      it "redirects to the new_post_path" do
        post :create, params: { post: FactoryBot.attributes_for(:post, body: "")}
        expect(response).to redirect_to(new_post_path)
        expect(flash[:alert]).to eq("Неверные данные")
      end
    end
  end

  describe "PUT #update" do
    let(:post){create(:post,user_id: user.id)}
    context "with valid attributes" do
      it "updates a created post" do
        put :update, params: { id: post.id, post: {body: "New body from test"}}
        post.reload
        expect(post.body).to eq("New body from test")
      end
      it "redirects to the root path" do
        put :update, params: { id: post.id, post: attributes_for(:post) }
        expect(response).to redirect_to(post_path)
        expect(flash[:notice]).to eq("Пост успешно обновлен")
      end
    end
    context "with invalid attributes" do
      it "updates a created post" do
        put :update, params: { id: post.id, post: {body: ""}}
        post.reload
        expect(post.body).to_not be_nil
      end
      it "redirects to the root path" do
        put :update, params: { id: post.id, post: {body: ""} }
        expect(response).to redirect_to(edit_post_path)
        expect(flash[:alert]).to eq("Неверные данные")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      user = FactoryBot.create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
      @post = create(:post,user_id: user.id)
    end
    it "destroys post" do
      expect{
        delete :destroy, params:{ id: @post.id }
      }.to change(Post, :count).by(-1)
    end
    it "redirects to the root path" do
      delete :destroy, params:{ id: @post.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Пост успешно удален")
    end
  end
end
