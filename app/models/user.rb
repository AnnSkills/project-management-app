class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  # has_one :account
  has_many :projects
  after_create :set_account
  acts_as_tenant(:account)

  def set_account
    #self.build_account
    self.account_id = current_account
  end

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
    params.require(:user).permit(:id, :email, :password)
  end

end
