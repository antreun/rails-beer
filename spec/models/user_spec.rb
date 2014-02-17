require 'spec_helper'

describe User do
	it "has the username set correctly" do
		user = User.new username:"Pekka"

		user.username.should == "Pekka"
	end

	it "is not saved without a password" do
		user = User.create username:"Pekka"
		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	it "is not saved with too short password" do
		user = User.create username:"Pekka", password: "S3c", password_confirmation: "S3c"
		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	it "is not saved without a number in password " do
		user = User.create username:"Pekka", password: "Salainen", password_confirmation: "Salainen"
		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end



	describe "with a proper password" do
		let(:user){ FactoryGirl.create(:user) }

		it "is saved" do
			expect(user).to be_valid
			expect(User.count).to eq(1)
		end

		it "and with two ratings, has the correct average rating" do
			user.ratings << FactoryGirl.create(:rating)
			user.ratings << FactoryGirl.create(:rating2)

			expect(user.ratings.count).to eq(2)
			expect(user.average_rating).to eq(15.0)
		end

		describe "favorite beer" do
			let(:user){FactoryGirl.create(:user) }

			it "has method for determining one" do
				user.should respond_to :favorite_beer
			end

			it "without ratings does not have one" do
				expect(user.favorite_beer).to eq(nil)
			end

			it "is the only rated if only one rating" do
				beer = FactoryGirl.create(:beer)
				rating = FactoryGirl.create(:rating, beer:beer, user:user)

				expect(user.favorite_beer).to eq(beer)
			end

			it "is the one with highest rating if several rated" do
		      create_beers_with_ratings(10, 20, 15, 7, 9, user)
		      best = create_beer_with_rating(25, user)

			  expect(user.favorite_beer).to eq(best)
			end
		end

		describe "favorite style" do
			let(:user){FactoryGirl.create(:user) }

			it "has method for determining one" do
				user.should respond_to :favorite_style
			end

			it "without ratings does not have one" do
				expect(user.favorite_style).to eq(nil)
			end

			it "is the only rated if only one rating" do
				create_styles
				beer = FactoryGirl.create(:beer, style_id:2)
				rating = FactoryGirl.create(:rating, beer:beer, user:user)
				expect(user.favorite_style).to eq(Style.find_by :id => beer.style_id)
			end

			it "is the one with highest ratings if several rated" do
				create_styles
		        create_beers_with_style_and_ratings(12, 22, 17, 9, 11, 2, user)
				best = FactoryGirl.create(:beer, style_id:2)
				rating = FactoryGirl.create(:rating, beer:best, user:user, score:25)
			  	expect(user.favorite_style).to eq(Style.find_by :id => best.style_id)
			end
		end


		describe "favorite brewery" do
			let(:user){FactoryGirl.create(:user) }

			it "has method for determining one" do
				user.should respond_to :favorite_brewery
			end

			it "without ratings does not have one" do
				expect(user.favorite_brewery).to eq(nil)
			end

			it "is the only rated if only one rating" do
				create_styles
				beer = FactoryGirl.create(:beer, style_id:2)
				rating = FactoryGirl.create(:rating, beer:beer, user:user)
				expect(user.favorite_brewery).to eq(beer.brewery)
			end

			it "is the one with highest ratings if several rated" do
				create_styles
				brewery1 = FactoryGirl.create(:brewery)
				brewery2 = FactoryGirl.create(:brewery, name:"testbrewery")
		        create_beers_with_brewery_and_ratings(12, 22, 17, 9, 11, brewery1, user)
		        create_beers_with_brewery_and_ratings(13, 23, 18, 19, 21, brewery2, user)
		        
			  	expect(user.favorite_brewery).to eq(brewery2)
			end
		end


	end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

	def create_beers_with_ratings(*scores, user)
	  scores.each do |score|
	    create_beer_with_rating(score, user)
	  end
	end

	def create_beers_with_style_and_ratings(*scores, style, user)
	  scores.each do |score|
	    beer = FactoryGirl.create(:beer, style_id:style)
    	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	  end
	end

	def create_beers_with_brewery_and_ratings(*scores, brewery, user)
	  scores.each do |score|
	    beer = FactoryGirl.create(:beer, brewery:brewery)
    	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	  end
	end

end