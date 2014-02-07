require 'spec_helper'

describe Beer do


  it "is not saved without a name" do
    beer = Beer.create style: "Test style"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Test beer"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is saved when name and style set" do
    beer = Beer.create name:"Test beer", style: "Test style"
    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end


end