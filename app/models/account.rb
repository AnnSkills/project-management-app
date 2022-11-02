class Account < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :users
  accepts_nested_attributes_for :users, allow_destroy: true

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
