class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_with_same_director(id)
    m = Movie.find(id)
    if !m.director.blank?
      Movie.where(:director => m.director)
    else
      nil
    end
  end
end
