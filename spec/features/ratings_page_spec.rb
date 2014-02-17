require 'spec_helper'

describe "Ratings page" do
  it "should not have any before been created" do
    visit ratings_path
    expect(page).to have_content 'List of ratings'
    expect(page).to have_content 'Number of ratings 0'
  end
end


describe "Ratings on user page" do
 describe "when ratings exists" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating) { FactoryGirl.create :rating, beer:beer1, user:user, score:'15' }
  let!(:rating2) { FactoryGirl.create :rating, beer:beer2, user:user, score:'25' }


  before :each do
    create_styles
    sign_in(username:"Pekka", password:"Foobar1")

  end

  it "lists the ratings and their total number" do
    visit ratings_path
    expect(page).to have_content "Number of ratings 2"
  end

  it "affect users favorite brewery" do  
    visit user_path(user)
    expect(page).to have_content 'Favorite brewery: Koff'
end


  it "affect users favorite style" do  
    visit user_path(user)
    expect(page).to have_content 'Favorite beer style: Lager'
end

  it "allows deleting ratings" do
    visit user_path(user)
    expect{
      page.find('li', :text => 'Karhu').click_link('delete')
    }.to change{Rating.count}.by(-1)

    expect{
        page.find('li', :text => 'iso 3').click_link('delete')
    }.to change{Rating.count}.by(-1)
  end

end


end
