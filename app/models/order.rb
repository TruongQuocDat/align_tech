# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  enum status: { confirmed: 0, approved: 1, rejected: 2 }

  validates :name, presence: true
end
