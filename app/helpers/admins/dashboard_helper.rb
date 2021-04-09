module Admins::DashboardHelper
  def user_order
    User.includes(:orders).pluck(:email, :id)
  end
end
