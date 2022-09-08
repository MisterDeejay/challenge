class Subscriber < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true, email: { mode: :strict, require_fqdn: true }
  validates :subscribed, inclusion: { in: [true, false], message: "must be true or false" }

  self.implicit_order_column = "created_at"

end
