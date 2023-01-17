require 'rails_helper'

RSpec.feature 'Queries', type: :feature do
  before :each do
    @user = User.create(email: 'test@gmail.com', password: 123_456)
    sign_in @user
    visit queries_index_path
  end

  describe 'analytics page' do
    it 'the user can see the analytics page' do
      expect(page).to have_content('Most searched')
    end

    it 'there is a table with Query and Instances as the header' do
      expect(page).to have_content('Query')
      expect(page).to have_content('Instances')
    end
  end
end
