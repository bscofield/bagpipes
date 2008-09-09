class Member < ActiveRecord::Base
  include Bagpipes::Models::Member

  def user_email; end

  def user_email=(value)
    # FIXME: Update this code to return a user object from your system when given an email address
    self.user = User.find_by_email(value)
  end
end