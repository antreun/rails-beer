require 'spec_helper'

describe "Beers page" do
  it "should not have any before been created" do
    visit beers_path
    expect(page).to have_content 'Listing beers'
    expect(page).to have_content 'Number of beers: 0'
  end


describe "when beers exists" do
  before :each do
    b = FactoryGirl.create(:brewery, name: "Koff", year: 1999)
    FactoryGirl.create(:beer, name:"Testbeer", style:"Lager", brewery:b)
    visit beers_path
  end

  it "lists the beers and their total number" do
    expect(page).to have_content "Number of beers: 1"
    expect(page).to have_content "Testbeer"
    expect(page).to have_content "Lager"
  end
  

  it "allows user to navigate to page of a beer" do
    click_link "Testbeer"
    expect(page).to have_content "Testbeer"
    expect(page).to have_content "Lager"
  end


end

  it "allows user to create a beer with correct name" do
    FactoryGirl.create(:brewery, name: "Koff", year: 1999)
    FactoryGirl.create(:user)
    sign_in(username:"Pekka", password:"Foobar1")
    visit beers_path
    click_link "New Beer"
    fill_in('Name', with:'Testbeer')
    select('Koff', from:'beer[brewery_id]')
    select('Lager', from:'beer[style]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(page).to have_content "Testbeer"
    expect(page).to have_content "Lager"

end

  it "does not allow user to create beer without a name" do
    FactoryGirl.create(:brewery, name: "Koff", year: 1999)
    FactoryGirl.create(:user)
    sign_in(username:"Pekka", password:"Foobar1")
    visit beers_path
    click_link "New Beer"
    fill_in('Name', with:'')
    select('Koff', from:'beer[brewery_id]')
    select('Lager', from:'beer[style]')

    click_button "Create Beer"
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
    
end
end