require 'rails_helper'

RSpec.feature 'Articles', type: :feature do
  before :each do
    @user = User.create(email: 'test@gmail.com', password: 123456)
    sign_in @user
    visit articles_path
  end

  describe 'root page' do
    it 'when the user logs in, they are presented with the articles page' do
      expect(page).to have_content('Articles')
    end

    it 'there is a link to add a new articles' do
      expect(page).to have_content('New article')
    end

    it 'there is a search button that the user can click' do
      expect(page).to have_content('Search')
    end

    it 'the button to add a new category brings the user to the page to create new category' do
      click_link 'New article'
      expect(page.body).to include('Create Article')
    end
    
  end
end