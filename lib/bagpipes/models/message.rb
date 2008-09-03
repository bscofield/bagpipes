module Bagpipes
  module Models
    module Message
      def self.included(base)
        base.class_eval do
          validates_presence_of :content
          validates_presence_of :member

          belongs_to :topic
          belongs_to :parent, :class_name => 'Message'
          has_many :children, :class_name => 'Message', :foreign_key => 'parent_id'
          belongs_to :member

          named_scope :by_recency, :order => 'created_at DESC'
          named_scope :children_of, lambda {|parent_id| {:conditions => {:parent_id => parent_id}}}
        end
      end

      def last_reply
        @last_reply ||= children.empty? ? self : children.by_recency.first
      end
    end
  end
end