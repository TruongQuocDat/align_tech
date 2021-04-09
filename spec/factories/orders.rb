# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer          default("confirmed"), not null
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
FactoryBot.define do
  factory :order do
    name { Faker::Name.unique.name }
  end
end
