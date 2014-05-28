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
  context 'logged out' do
    it 'prompts us to sign in' do
      visit '/posts'
      click_link 'New post'

      expect(page).to have_content 'Sign in'
    end
  end

  context 'logged in' do
    before do
      user = User.create(email: 'alex@a.com', password: '12345678', password_confirmation: '12345678')
      login_as user
    end

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
end

describe 'deleting posts' do
  context 'my post' do
    before do
      alex = User.create(email: 'alex@a.com', password: '12345678', password_confirmation: '12345678')
      login_as alex
      Post.create(title: 'Hello', description: 'World', user: alex)
    end

    it 'is removed from the posts page' do
      visit '/posts'
      click_link 'Delete'

      expect(page).to have_content 'Successfully deleted'
    end
  end

  context 'not my post' do
    before do
      alex = User.create(email: 'alex@a.com', password: '12345678', password_confirmation: '12345678')
      emma = User.create(email: 'emma@a.com', password: '12345678', password_confirmation: '12345678')
      Post.create(title: "Emma's pic", description: 'Test', user: emma)

      login_as alex
    end

    it 'shows no delete link' do
      visit '/posts'
      expect(page).not_to have_link "Delete"
    end
  end
end


