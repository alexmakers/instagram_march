require 'spec_helper'

describe 'tagging posts' do
  before do
    alex = create(:user)
    login_as alex
  end

  it 'displays the tags on the posts page' do
      visit '/posts/new'
      fill_in 'Title', with: 'My new post'
      fill_in 'Description', with: 'Lorem ipsum'
      attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')
      fill_in 'Tags', with: 'yolo, swag'
      click_button 'Post it!'

      expect(page).to have_link '#yolo'
      expect(page).to have_link '#swag'
  end
end