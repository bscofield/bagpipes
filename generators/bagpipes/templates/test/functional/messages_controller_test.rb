require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  def setup
    login_as :quentin
    @user = users(:quentin)
    @user.create_member :name => 'Member'
    @topic = Topic.create! :title => "Test Topic"
  end
  
  test "index should render" do
    get :index, :topic_id => @topic.id
    assert_template 'index'
  end
  
  test "new should render" do
    get :new, :topic_id => @topic.id
    assert_template 'new'
  end
  
  test "show should render" do
    @message = @topic.messages.create :title => 'Test Message', :content => 'test content', :member => @user.member
    get :show, :topic_id => @topic.id, :id => @message.id
    assert_template 'show'
  end
  
  test "show unknown message should redirect" do
    get :show, :topic_id => @topic.id, :id => 0
    assert_redirected_to topic_messages_path(@topic)
  end
  
  test "show unknown message should set flash" do
    get :show, :topic_id => @topic.id, :id => 0
    assert flash[:error]
  end
  
  test "unknown topic should redirect" do
    get :new, :topic_id => 0
    assert_redirected_to topics_path
  end

  test "unknown topic should set flash" do
    get :new, :topic_id => 0
    assert flash[:error]
  end
  
  test "bad create should render" do
    post :create, {:topic_id => @topic.id}.merge(bad_params)
    assert_template 'new'
  end
  
  test "bad create should set flash" do
    post :create, {:topic_id => @topic.id}.merge(bad_params)
    assert flash.now[:form_error]
  end
  
  test "good create should add record" do
    assert_difference 'Message.count' do
      post :create, {:topic_id => @topic.id}.merge(good_params)
    end
  end
  
  test "good create should redirect" do
    post :create, {:topic_id => @topic.id}.merge(good_params)
    assert_redirected_to topic_messages_path(@topic)
  end
  
  test "create reply should redirect elsewhere" do
    m = @topic.messages.create! :title => 'Test Message', :content => 'Test content for message', :member => @user.member
    post :create, :topic_id => @topic.id, :message => {
      :title => 'Test Reply',
      :content => 'Reply to this',
      :parent_id => m.id
    }
    assert_redirected_to topic_message_path(@topic, m)
  end
  
  test "good create should set flash" do
    post :create, {:topic_id => @topic.id}.merge(good_params)
    assert flash[:notice]
  end
  
  private
  def good_params
    {:message => {:title => 'Test Message', :content => 'Test content for a message'}}
  end
  
  def bad_params
    {:message => {:title => '', :content => ''}}
  end
end
