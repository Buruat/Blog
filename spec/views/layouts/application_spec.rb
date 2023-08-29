require 'rails_helper'
require 'factory_bot_rails'
require 'faker'

RSpec.describe 'layouts/application.html.erb', type: :view do
  include Devise::Test::ControllerHelpers
  context 'renders the flash messages correctly' do
    it 'render notice' do
      flash[:notice] = 'This is a notice message'
      render
      expect(rendered).to have_selector('p.message.message-notice')
      expect(rendered).to have_content('This is a notice message')
    end
    it 'render alert' do
      flash[:alert] = 'This is an alert message'
      render
      expect(rendered).to have_selector('p.message.message-alert')
      expect(rendered).to have_content('This is an alert message')
    end
  end

  it 'renders the correct links and buttons for signed in users' do
    user = create(:user)
    sign_in user

    render

    expect(rendered).to have_link('Блог', href: root_path)
    expect(rendered).to have_button('Профиль', type: 'submit')
    expect(rendered).to have_button('Выйти', type: 'submit')
    expect(rendered).not_to have_button('Войти', type: 'submit')
    expect(rendered).not_to have_button('Зарегистрироваться', type: 'submit')
  end

  it 'renders the correct links and buttons for non-signed in users' do
    render

    expect(rendered).to have_link('Блог', href: root_path)
    expect(rendered).not_to have_button('Профиль', type: 'submit')
    expect(rendered).not_to have_button('Выйти', type: 'submit')
    expect(rendered).to have_button('Войти', type: 'submit')
    expect(rendered).to have_button('Зарегистрироваться', type: 'submit')
  end
end