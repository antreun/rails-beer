require 'spec_helper'

include OwnTestHelper

describe "User" do
  before :each do
    create_styles
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end


  it "has ratings shown correctly on the page" do
    brewery = FactoryGirl.create :brewery, name:"Koff" 
    beer1 = FactoryGirl.create :beer, name:"iso 3", brewery:brewery 
    beer2 = FactoryGirl.create :beer, name:"Karhu", brewery:brewery 
    u2 = FactoryGirl.create :user, username:"Testi"
    FactoryGirl.create :rating, beer:beer1, user:User.first, score:'15' 
    FactoryGirl.create :rating, beer:beer2, user:User.first, score:'25' 
    FactoryGirl.create :rating, beer:beer2, user:u2, score:'22' 
    sign_in(username:"Pekka", password:"Foobar1")
    visit user_path(User.first)
    expect(page).to have_content 'made 2 ratings'
    visit user_path(u2)
    expect(page).to have_content 'made 1 rating'

end


end
