class Project < ApplicationRecord
  acts_as_tenant :account
  belongs_to :account
  accepts_nested_attributes_for :account
  validates :account_id, presence: true
end
