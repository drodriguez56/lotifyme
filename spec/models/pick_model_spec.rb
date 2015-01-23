require 'rails_helper'

describe Pick do
   it "is valid with numbers, game, draw_date" do
    pick = Pick.new(
      numbers:"313577796306",
      game: "powerball",
      draw_date: "01/13/15")
    expect(pick).to be_truthy
   end
   it "is invalid without numbers"
   it "is invalid without game"
   it "is invalid with draw_date"
   it "does not allow duplicate emails"
end