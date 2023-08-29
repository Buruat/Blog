require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe "posts/new.html.erb", type: :view do
  it "renders the form" do
    assign(:post, Post.new)
    render
    expect(rendered).to have_selector("form[action='#{posts_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='post[title]'][type='text']")
      expect(rendered).to have_selector("textarea[name='post[description]']")
      expect(rendered).to have_selector("textarea[name='post[body]']")
      expect(rendered).to have_selector("input[type='file'][name='post[image]']")
      expect(rendered).to have_selector("input[type='submit'][value='Сохранить']")
    end
  end
end