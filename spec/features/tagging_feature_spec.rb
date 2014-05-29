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

  describe 'filter posts by tag' do
    before do
      create(:post, title: 'Pic1', tag_names: 'yolo')
      create(:post, title: 'Pic2', tag_names: 'swag')
      visit '/posts'
    end

    it 'uses the tag name in the url' do
      click_link '#yolo'
      expect(current_path).to eq '/tags/yolo'
    end

    it 'only shows posts with the selected tag' do
      click_link '#yolo'

      expect(page).to have_css 'h1', text: 'Posts tagged with #yolo'
      expect(page).to have_content 'Pic1'
      expect(page).not_to have_content 'Pic2'
    end
  end

end