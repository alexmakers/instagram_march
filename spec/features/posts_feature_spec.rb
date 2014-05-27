require 'spec_helper'

describe 'posts' do
  context 'no posts' do
    it 'displays a prompt to create posts' do
      visit '/posts'

      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'New post'
    end
  end

  context 'with posts' do
    before { Post.create(title: 'Cool post', description: 'Hello world') }

    it 'displays the posts' do
      visit '/posts'

      expect(page).to have_content 'Cool post'
    end
  end
end

describe 'creating posts' do
  it 'adds the post to the homepage' do
    visit '/posts/new'
    fill_in 'Title', with: 'My new post'
    fill_in 'Description', with: 'Lorem ipsum'
    attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')

    click_button 'Post it!'

    expect(current_path).to eq posts_path
    expect(page).to have_content 'My new post'
    expect(page).to have_css 'img.uploaded-pic'
  end




end