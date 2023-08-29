require 'rails_helper'
require 'factory_bot_rails'
require 'faker'

RSpec.describe "posts/show.html.erb", type: :view do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user1 = FactoryBot.create(:user, email: "user1@user.com")
    sign_in @user1
    @current_user = @user1
    @user2 = FactoryBot.create(:user, email: "user2@user.com")
    @post = FactoryBot.create(:post,
      title: "Title",
      body: "Body",
      user_id: @user1.id
    )
    @comment1 = FactoryBot.create(:comment,
      body: "Comment 1",
      user_id: @user1.id,
      post_id: @post.id
    )
    @comment2 = FactoryBot.create(:comment,
      body: "Comment 2",
      user_id: @user2.id,
      post_id: @post.id
    )
    render
  end

  it "displays post title" do
    expect(rendered).to have_selector("h1.title-lg", text: "Title")
  end

  it "displays post image" do
    if @post.image.attached?
      expect(rendered).to have_selector("p.image-show img")
    else
      expect(rendered).not_to have_selector("p.image-show img")
    end
  end

  it "displays post body" do
    expect(rendered).to have_selector("p.word-wrap", text: "Body")
  end

  it "displays post author" do
    expect(rendered).to have_selector("p.post-footer", text: "Автор: user1@user.com")
  end

  it "displays post created date" do
    expect(rendered).to have_selector("p.mb-lg", text: @post.created_at.strftime(('%H:%M %d-%m-%Y')))
  end

  it "displays 'Изменить' button if user is the author of the post" do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(@user1)
    expect(rendered).to have_selector("div.mb-sm button[type='submit']", text: "Изменить")
  end

  it "displays 'Удалить' button if user is the author of the post" do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(User.create(email: "user1@user.com"))
    expect(rendered).to have_selector("div.mb-md button[type='submit']", text: "Удалить")
  end

  it "displays 'Назад' button" do
    expect(rendered).to have_selector("div button[type='submit']", text: "Назад")
  end

  it "displays comments" do
    expect(rendered).to have_text("user1@user.com")
    expect(rendered).to have_text("Comment 1")
    expect(rendered).to have_text("user2@user.com")
    expect(rendered).to have_text("Comment 2")
  end

  it "displays 'Добавить комментарий' title" do
    expect(rendered).to have_selector("h2.title-md", text: "Добавить комментарий")
  end

  it "displays comment form" do
    expect(rendered).to have_selector("form")
    expect(rendered).to have_selector("form input[type='submit'][value='Сохранить']")
  end
end
