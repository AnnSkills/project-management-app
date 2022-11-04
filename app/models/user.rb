class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable#, omniauth_providers: [:stripe_connect]
  has_many :accounts
  has_many :projects
  has_many :invites, class_name: 'User', foreign_key: :invited_by_id
  acts_as_tenant(:account)

  def can_receive_payments?
    uid? &&  provider? && access_code? && publishable_key?
  end
end
