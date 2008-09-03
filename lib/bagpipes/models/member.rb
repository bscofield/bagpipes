module Bagpipes
  module Models
    module Member
      def self.included(base)
        base.class_eval do
          validates_presence_of :name
          validates_presence_of :user

          has_many :messages, :dependent => :destroy

          belongs_to :user, :polymorphic => true
        end
      end
    end
  end
end