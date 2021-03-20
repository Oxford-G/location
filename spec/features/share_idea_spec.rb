require 'rails_helper'

RSpec.feature 'ShareIdea', type: :feature do
  before :each do
    @user = User.create(username: 'Johnny', fullname: 'passwordss', photo: 'photoss.com',
                        cover_image: 'coverimagess.com', email: 'chech@xhchess.com')
    visit root_path
    fill_in 'username', with: @user.username
    click_button 'Login'
    @locate = Locate.new(author: @user, text: 'Hello!')
    visit locates_path
  end

  it 'user can share an idea' do
    fill_in 'locate', with: @locate.text
    click_button 'Share'
    expect(page).to have_text('Idea successfully shared')
  end
end