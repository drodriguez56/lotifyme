FactoryGirl.define do
  factory :pick do
    number { Faker::Number.number(12) }
    draw_date { Faker::Time.between(30.days.ago, Time.now) }
    password { Faker::Internet.password }
    game { "Powerball" }
    user_id {Faker::Number.number(3)}
    multiplier { 3 }
  end

  factory :failed_pick, class: Pick do
    draw_date { Faker::Time.between(30.days.ago, Time.now) }
    password { Faker::Internet.password }
    game { "Powerball" }
    user_id {Faker::Number.number(3)}
    multiplier { 3 }
  end

#powerball factories
  factory :jackpot_pick_powerball, class: Pick do
    draw_date { '24-01-2015' }
    game { "Powerball" }
    multiplier { true }
    number { '11 12 13 14 15 16' }
  end

  factory :threep_pick_powerball, class: Pick do
    draw_date { '24-01-2015' }
    game { "Powerball" }
    multiplier { true }
    number { '11 12 13 77 77 16' }
  end

  factory :zero_pick_powerball, class: Pick do
    draw_date { '24-01-2015' }
    game { "Powerball" }
    multiplier { true }
    number { '77 77 77 77 77 77' }
  end

#mega millions factories
  factory :jackpot_pick_mega_millions, class: Pick do
    draw_date { '21-01-2015' }
    game { "MegaMillion" }
    multiplier { true }
    number { '11 12 13 14 15 16' }
  end

  factory :threep_pick_mega_millions, class: Pick do
    draw_date { '21-01-2015' }
    game { "MegaMillion" }
    multiplier { true }
    number { '11 12 13 77 77 16' }
  end

  factory :zero_pick_mega_millions, class: Pick do
    draw_date { '21-01-2015' }
    game { "MegaMillion" }
    multiplier { true }
    number { '77 77 77 77 77 77' }
  end
#ny lotto factories
  factory :jackpot_pick_nylotto, class: Pick do
    draw_date { '17-01-2015' }
    game { "NyLotto" }
    number { '11 12 13 14 15 16 17' }
  end

  factory :three_pick_nylotto, class: Pick do
    draw_date { '17-01-2015' }
    game { "NyLotto" }
    number { '11 12 13 77 77 77 77' }
  end

  factory :threep_pick_nylotto, class: Pick do
    draw_date { '17-01-2015' }
    game { "NyLotto" }
    number { '11 12 13 77 77 77 17' }
  end

  factory :fivep_pick_nylotto, class: Pick do
    draw_date { '17-01-2015' }
    game { "NyLotto" }
    number { '11 12 13 14 77 16 17' }
  end

  factory :zero_pick_nylotto, class: Pick do
    draw_date { '17-01-2015' }
    game { "NyLotto" }
    number { '77 77 77 77 77 77 77' }
  end
#cash4life factories
  factory :jackpot_pick_cash4life, class: Pick do
    draw_date { '14-01-2015' }
    game { "Cash4Life" }
    number { '11 12 13 14 15 16' }
  end

  factory :threep_pick_cash4life, class: Pick do
    draw_date { '14-01-2015' }
    game { "Cash4Life" }
    number { '11 12 13 77 77 16' }
  end

  factory :zero_pick_cash4life, class: Pick do
    draw_date { '14-01-2015' }
    game { "Cash4Life" }
    number { '77 77 77 77 77 77' }
  end
  #take5 factories
  factory :jackpot_pick_take5, class: Pick do
    draw_date { '14-01-2015' }
    game { "Take5" }
    number { '11 12 13 14 15' }
  end

  factory :zero_pick_take5, class: Pick do
    draw_date { '14-01-2015' }
    game { "Take5" }
    number { '77 77 77 77 77' }
  end
  #pick10 factories
  factory :jackpot_pick_pick10, class: Pick do
    draw_date { '14-01-2015' }
    game { "Pick10" }
    number { '11 12 13 14 15 16 17 18 19 20' }
  end

  factory :one_pick_pick10, class: Pick do
    draw_date { '14-01-2015' }
    game { "Pick10" }
    number { '11 77 77 77 77 77 77 77 77 77' }
  end

  factory :zero_pick_pick10, class: Pick do
    draw_date { '14-01-2015' }
    game { "Pick10" }
    number { '77 77 77 77 77 77 77 77 77 77' }
  end
end