require 'spec_helper'

describe 'admins' do
  it 'can sign in' do
    visit '/admins/sign_in'
    expect(page).to have_content 'Sign in'
  end

  it 'cannot sign up' do
    expect { visit '/admins/sign_up' }.to raise_error
  end
end