require 'rails_helper'
require_relative '../../support/login_form'

feature 'edit post' do
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  let(:post) { create(:post, user: user) }

  context 'guest user' do
    before do
      visit(edit_post_path(post))
    end

    scenario 'it redirects to login page' do
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context 'authenticated user who' do
    subject(:login_form) { LoginForm.new }

    context 'is not owner of post' do
      before do
        login_form.visit_page.login_as(user_2)
        visit(edit_post_path(post))
      end

      scenario 'sees not found content' do
        expect(page).to have_content(/Page not found/)
      end
    end

    context 'is owner of post' do
      before do
        login_form.visit_page.login_as(user)
        visit(post_path(post))
        click_on("Edit Post")
      end

      scenario 'sees form with post data' do
        expect(page).to have_xpath("//input[@id='post_title']")
        expect(page).to have_xpath("//textarea[@id='post_content']")
        expect(page.find(:xpath, "//input[@id='post_title']").value)
          .to eq(post.title)
        expect(page.find(:xpath, "//textarea[@id='post_content']").value)
          .to eq(post.content)
        expect(page.find_button('Update Post'))
      end

      scenario 'can make changes to the post' do
        new_title = "Very EPIC title"
        fill_in("Title", with: new_title)
        click_on("Update Post")

        expect(page).to have_content("Post updated successfully")
        expect(page).to have_content(new_title)
        expect(page.current_path).to eq(post_path(post))
      end
    end
  end
end
