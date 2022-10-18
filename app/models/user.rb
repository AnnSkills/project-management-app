class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_one :account
  before_validation :set_account
  before_create :set_account
  #acts_as_tenant(:account)
  def set_account
    self.build_account
  end
end
