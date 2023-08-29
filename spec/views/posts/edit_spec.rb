require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe "posts/edit.html.erb", type: :view do
  let(:user){create(:user)}
  let(:post) {create(:post,user_id: user.id)}

  it "displays the form for editing a post" do
    assign(:post, post)
    render

    expect(rendered).to have_selector("form[action='#{post_path(post)}'][method='post']")

    expect(rendered).to have_selector("input[type='text'][name='post[title]'][class='form-text-field']")

    expect(rendered).to have_selector("textarea[name='post[description]'][rows='2'][class='form-text-area']")

    expect(rendered).to have_selector("textarea[name='post[body]'][rows='5'][class='form-text-area']")

    expect(rendered).to have_selector("input[type='file'][name='post[image]']")

    expect(rendered).to have_selector("input[type='submit'][value='Сохранить'][class='button button-main']")
  end
end

