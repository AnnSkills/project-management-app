class Project < ApplicationRecord
  acts_as_tenant :account
  belongs_to :project
  belongs_to :user
  accepts_nested_attributes_for :account
end
