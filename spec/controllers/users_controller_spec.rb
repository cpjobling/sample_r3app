require 'spec_helper'

describe UsersController do

  render_views
  
  describe "GET 'new'" do
    
    before(:each) do
      get :new
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title",
        :content => "Sign up")
    end
    
    describe "Sign up form" do

      it "should have a name field" do
        response.should have_selector("input", 
        {
          :id => "user_name", 
          :type => 'text', 
          :name => 'user[name]'
        })
      end

      it "should have an email field" do
        response.should have_selector("input", 
        {
          :id => "user_email", 
          :type => 'text', 
          :name => 'user[email]'
        })
      end

      it "should have a password field" do
        response.should have_selector("input", 
        {
          :id => "user_password", 
          :type => 'password', 
          :name => 'user[password]'
        })
      end

      it "should have a password confirmation field" do
        response.should have_selector("input", 
        {
          :id => "user_password_confirmation", 
          :type => 'password', 
          :name => 'user[password_confirmation]'
        })
      end

    end
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end
    
    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { 
          :name => "", 
          :email => "", 
          :password => "", 
          :password_confirmation => "" 
        }
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      
      it "should clear the password field" do
        post :create, :user =>@attr.merge(:password => "foobar", :password_confirmation => "fuzzbar")
        response.should have_selector("input[name='user[password]'][type='password']", :value=>"")
      end
      
      it "should clear the password confirmation field" do
        post :create, :user =>@attr.merge(:password => "foobar", :password_confirmation => "fuzzbar")
        response.should have_selector("input[name='user[password_confirmation]'][type='password']", :value=>"")
      end
      
    end
    
    describe "success" do

      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample rails 3 application/i
      end
    end

  end
  
  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit profile")
    end
    
    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      esponse.should have_selector("a", :href=> gravatar_url, :content => "change")
    end
  end
    
  describe "POST 'update'"  do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    describe "failure"
      
    describe "sucesss"
        
  end

end
