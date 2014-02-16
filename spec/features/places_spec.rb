require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API, they are shown at the page" do
    BeermappingApi.stub(:places_in).with("testikaupunki").and_return(
        [ Place.new(:name => "Oljenkorsi"),
         Place.new(:name => "Kulmakuppila"),
         Place.new(:name => "Oluthuone") ]
    )

    visit places_path
    fill_in('city', with: 'testikaupunki')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kulmakuppila"
    expect(page).to have_content "Oluthuone"
  end

  it "if NONE is returned by the API, no locations are shown" do

    BeermappingApi.stub(:places_in).with("helsinki").and_return(
        [  ]
    )
    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "No locations in"
  end

end