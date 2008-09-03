module Bagpipes
  module Models
    module Topic
      def self.included(base)
        base.class_eval do
          validates_presence_of :title

          has_many :messages, :dependent => :destroy

          named_scope :by_title, :order => 'title ASC'
        end
      end

      def last_message
        @last_message ||= messages.by_recency.first || self
      end
    end
  end
end