require 'spec_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name:"Nikolai", brewery: @brewery1, style_id:@style1.id)
    @beer2 = FactoryGirl.create(:beer, name:"Fastenbier", brewery:@brewery2, style_id:@style2.id)
    @beer3 = FactoryGirl.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style_id:@style3.id)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows a known beer", js: true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    #save_and_open_page    
    #byebug
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in alphabetical order by default", js: true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)').should have_content('Fastenbier')
    find('table').find('tr:nth-child(3)').should have_content('Lechte Weisse')
    find('table').find('tr:nth-child(4)').should have_content('Nikolai')
  end

  it "shows beers ordered by style when clicked", js: true do
    visit beerlist_path
    click_link('Style')
    find('table').find('tr:nth-child(2)').should have_content('Lager')
    find('table').find('tr:nth-child(3)').should have_content('Rauchbier')
    find('table').find('tr:nth-child(4)').should have_content('Weizen')
  end  
  
  it "shows beers ordered by brewery when clicked", js: true do
    visit beerlist_path
    click_link('Brewery')
    find('table').find('tr:nth-child(2)').should have_content('Ayinger')
    find('table').find('tr:nth-child(3)').should have_content('Koff')
    find('table').find('tr:nth-child(4)').should have_content('Schlenkerla')
  end  

end