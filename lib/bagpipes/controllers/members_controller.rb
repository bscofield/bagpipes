module Bagpipes
  module Controllers
    module MembersController
      def self.included(base)
        base.class_eval do
          before_filter :require_member_admin
        end
      end
      
      # TODO: optionally, paginate
      def index
        @members = Member.all
      end
      
      def new
        @member = Member.new
      end
      
      def create
        @member = Member.new(params[:member])
        
        if @member.save
          flash[:notice] = "The member #{@member.name} has been created"
          redirect_to members_path
        else
          flash[:form_error] = @member
          render :action => 'new'
        end
      end
      
      # TODO: add show action to view member information and posts/replies made

      include FlashErrorsHelper
      protected :grab_errors_from_object
      protected :grab_errors_for_flash

      private
      # TODO: extract filter from here and TopicsController
      def require_member_admin
        unless logged_in? && current_user.member && current_user.member.administrator?
          flash[:error] = "You must be a forum administrator to do that"
          redirect_to topics_path
        end
      end
    end
  end
end