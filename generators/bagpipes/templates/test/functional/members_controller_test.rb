require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  def setup
    user = users(:quentin)
    user.create_member :administrator => true, :name => 'Admin'
    login_as :quentin
  end

  test "index should render" do
    get :index
    assert_template 'index'
  end

  test "new should render" do
    get :new
    assert_template 'new'
  end

  test "bad post should render" do
    post :create, bad_params
    assert_template 'new'
  end

  test "bad post should set flash" do
    post :create, bad_params
    assert flash.now[:form_error]
  end

  test "good post should redirect" do
    post :create, good_params
    assert_redirected_to members_path
  end

  test "good post should set flash" do
    post :create, good_params
    assert flash[:notice]
  end

  test "good post should create record" do
    assert_difference 'Member.count' do
      post :create, good_params
    end
  end

  private
  def bad_params
    {:member => {:name => '', :user_email => ''}}
  end

  def good_params
    {:member => {:name => 'Test User', :user_email => users(:quentin).email}}
  end

end
