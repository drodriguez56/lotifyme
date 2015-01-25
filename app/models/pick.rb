class Pick < ActiveRecord::Base

	before_save { |pick| pick.set_date_to_next_draw; pick.assign_draw_id }
  after_save { |pick| pick.setresult }

  validates :number, presence: true
  validates :game, presence: true
  validates :draw_date, presence: true
  validates_uniqueness_of :user, scope: [:number, :game, :draw_date]

  belongs_to :user
  belongs_to :draw

	def set_date_to_next_draw
    if self.game == 'mega_millions' || self.game == 'powerball' || self.game == 'nylotto'
  		until [3, 6].include?(Date.parse(self.draw_date.to_s).cwday)
  			self.draw_date += 24 * 60 * 60
  		end
    end
    draw_date = Date.parse((self.draw_date.to_s)[0..9])
    self.draw_date = draw_date
	end

  def assign_draw_id
    draw = Draw.find_by(draw_date: self.draw_date)
    if draw
      self.draw_id = draw.id
    end
  end

  def setresult
    if self.game == 'powerball'
      self.powerball(self.getscore)
    elsif self.game == 'mega_millions'
      self.mega_millions(self.getscore)
    elsif self.game == 'nylotto'
      self.nylotto(self.getscore)
    elsif self.game == 'cash4life'
      self.cash4life(self.getscore)
    elsif self.game == 'take5'
      self.take5(self.getscore)
    elsif self.game == 'pick10'
      self.pick10(self.getscore)
    end
  end

  def getscore
  #these are simple match type games (take5 || nylotto || pick10)
    if self.game == 'take5' || self.game == 'pick10'
      self.matchscore
    elsif self.game == 'nylotto'
      self.nylottoscore
  #these are matching type games with a bonus ball ('mega_millions' || 'powerball' || 'cash4life')
    else
      self.bonusballscore
    end
  end

  def matchscore
    draw = self.draw
    pickarr = self.number.split(' ')
    drawarr = draw.number.split(' ')
    match = pickarr & drawarr
    return match.length.to_s
  end


  def bonusballscore
    draw = self.draw
    pickarr = self.number.split(' ')
    drawarr = draw.number.split(' ')
    power_pick = pickarr.pop
    power_draw = drawarr.pop
    match = pickarr & drawarr
      if power_pick == power_draw
        score = match.length.to_s + 'P'
      else
        score = match.length.to_s
      end
    end
  end
end

