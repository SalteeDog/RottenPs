class Movie < ActiveRecord::Base

  def self.All_ratings
   return  ['G','PG','PG-13','R']
  end

end
