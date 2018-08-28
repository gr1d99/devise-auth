require 'rails_helper'
require_relative '../../support/login_form'

feature 'list all posts' do
  subject(:login_form) { LoginForm.new }

  context 'when user has posts' do
    before :all do
      @user = create(:user)
      @post1 = Post.create(
        title: Faker::Book.title,
        content: Faker::Lorem.paragraph,
        user: @user
      )
      @post2 = Post.create(
        title: Faker::Book.title,
        content: Faker::Lorem.paragraph,
        user: @user
      )
    end

    after(:all) do
      User.destroy_all
    end

    scenario 's(he) can see posts she created' do
      login_form.visit_page.login_as(@user)
      visit('/posts')

      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
    end
  end
end
