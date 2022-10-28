class User < ApplicationRecord

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :accounts
  has_many :projects
  has_many :invites, class_name: 'User', foreign_key: :invited_by_id
  acts_as_tenant(:account)

  def to_s
    email
  end

  def can_receive_payments?
    uid? &&  provider? && access_code? && publishable_key?
  end

  private

  after_create do
    customer = Stripe::Customer.create(email: self.email)
    update(stripe_customer_id: customer.id)
    self.stripe_customer_id = customer.id
  end
  def user_params
    params.require(:user).permit(:id, :email, :password, :account_id)
  end
end
