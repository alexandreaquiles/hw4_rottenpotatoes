require 'spec_helper'

describe Movie do
  fixtures :movies
  
  context "the director has other movies" do
    it "should find movies with the same director as the argument" do
      m = Movie.find_with_same_director("1")
      m.size.should == 2
      m.should include(movies(:one), movies(:three))
      m.should_not include(movies(:two))
    end
  end
  
  context "finding movies with the same director when the movie hasn't a director" do
    it "should return nil when the movie hasn't a director" do
       m = Movie.find_with_same_director("4")
       m.should be_nil
    end
  end
end
