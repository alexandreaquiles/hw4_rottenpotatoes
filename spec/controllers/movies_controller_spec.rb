require 'spec_helper'

describe MoviesController do

  describe 'find movies with same director' do

    it 'should call the model method that finds movies by director' do
      Movie.should_receive(:find_with_same_director).with("1").and_return([mock('Movie')])
      get :same_director, {:id => 1}
    end
    
    it 'should select the Same Director template for rendering' do
      Movie.stub(:find_with_same_director).and_return([mock('Movie')])
      get :same_director, {:id => 1}
      response.should render_template('same_director')
    end
    
    it 'should make director\'s movies available the template' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_with_same_director).and_return(fake_results)
      get :same_director, {:id => 1}
      assigns(:movies).should == fake_results
    end
    
    it 'should redirect to home page if movie has no director' do
      Movie.stub(:find_with_same_director).and_return(nil)
      m = mock('Movie')
      m.stub(:title).and_return("The End")
      Movie.stub(:find).and_return(m)
      get :same_director, {:id => 1}
      response.should redirect_to movies_path
    end
    
    it 'should delete an existing movie' do
      m = mock('Movie')
      Movie.should_receive(:find).with("1").and_return(m)
      m.should_receive(:destroy)
      m.should_receive(:title).and_return("The End")
    
      delete :destroy, {:id => 1}
      response.should redirect_to movies_path
      flash[:notice].should == "Movie 'The End' deleted."
    end
    
    it 'should create a new movie' do
      movie = {"title" => 'Just Created', "rating" => 'R', "director" => 'Me'}
      m = mock('Movie')
      m.should_receive(:title).and_return("Just Created")
      Movie.should_receive(:create!).with(movie).and_return(m)

      post :create, {:movie => movie}
      response.should redirect_to movies_path
      flash[:notice].should == "Just Created was successfully created."
    end
    
  end

end
