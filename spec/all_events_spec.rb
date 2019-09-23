require 'rails_helper'

RSpec.describe 'All Events', type: :feature do
    scenario 'index page' do
      visit root_path
      expect(page).to have_content('All Events')
    end
end