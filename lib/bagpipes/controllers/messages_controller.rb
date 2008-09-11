module Bagpipes
  module Controllers
    module MessagesController
      def self.included(base)
        base.class_eval do
          before_filter :require_topic
          before_filter :require_member_login, :except => [:show, :index]

          layout 'bagpipes'
        end
      end

      # TODO: provide modular search for messages via index action
      def index; end

      def new
        @parent = @topic.messages.find_by_id(params[:parent_id])
        parent_params = @parent ? {
          :parent_id => @parent.id,
          :title => "Re: #{@parent.title}"
        } : {}

        @message = @topic.messages.build(parent_params)
      end

      # TODO: optionally, paginate replies
      def show
        @message = @topic.messages.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This message no longer exists"
        redirect_to topic_messages_path(@topic)
      end

      def create
        @message = @topic.messages.build(params[:message].merge({:member => current_user.member}))

        if @message.save
          flash[:notice] = "You have created a new message in \"#{@topic.title}\""
          redirect_to @message.parent ? topic_message_path(@topic, @message.parent) : topic_messages_path(@topic)
        else
          flash.now[:form_error] = @message
          render :action => 'new'
        end
      end

      private
      def require_topic
        @topic = Topic.find(params[:topic_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This parent topic no longer exists"
        redirect_to topics_path
      end

      def require_member_login
        unless logged_in? && current_user.member
          flash[:error] = "You must be a member of the forum to do that"
          redirect_to @topic
        end
      end

      include FlashErrorsHelper
      protected :grab_errors_from_object
      protected :grab_errors_for_flash
    end
  end
end