require 'rails_helper'

describe User do
  xit "should be associated with picks" do
    user = User.create(
      username:"lemons",
      password: "peelinglemons",
      email: 2)
    pick = user.picks.create(
      number: "342047591204",
      game: "powerball",
      draw_date: "2015-01-12 03:11:34")
    expect(pick).to be_truthy
  end

  it "is invalid without an email address" do
    user = User.create(
      username:"honeybadger",
      password: "ilikedacoco",
      email: nil)
    user.valid?
    expect(User.all).not_to include user
  end


  it "is valid because password is long enough" do
    user = User.create(
      username:"honeybadger",
      password: "123456",
      email: "hbd@gang.com",
      #phone: Faker::PhoneNumber.phone_number,
      active: true)
    user.valid?
    expect(User.all).to include user
  end
end
