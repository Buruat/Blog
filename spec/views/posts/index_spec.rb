require 'rails_helper'
require 'factory_bot_rails'
require 'faker'

RSpec.describe 'posts/index.html.erb', type: :view do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    assign(:posts,Kaminari.paginate_array([
      FactoryBot.create(:post, title: "post 1", description: "description 1", user_id: @user1.id),
      FactoryBot.create(:post, title: "post 2", description: "description 2", user_id: @user2.id)]).page(1).per(4))
  end

  context "when filter is 'Все посты'" do
    before(:each) do
      render
    end

    it "displays all posts" do
      expect(rendered).to have_content("post 1")
      expect(rendered).to have_content("description 1")
      expect(rendered).to have_content("post 2")
      expect(rendered).to have_content("description 2")
    end
  end

  it "displays all posts" do
    render
    expect(rendered).to have_link("post 1", href: post_path(Post.first))
    expect(rendered).to have_text("description 1")
    expect(rendered).to have_link("post 2", href: post_path(Post.last))
    expect(rendered).to have_text("description 2")
  end

  it "displays the 'Создать статью' link" do
    render

    expect(rendered).to have_link("Создать статью", href: new_post_path)
  end
end
