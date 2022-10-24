class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_one :account
  has_many :projects
  # before_validation :set_account
  after_create :set_account
  acts_as_tenant(:account)
  # last commented

  # belongs_to :account
  # accepts_nested_attributes_for :account
  #
  # acts_as_tenant(:account)
  # extend DeviseOverrides


  def set_account
    self.build_account
    # self.account_id = ActsAsTenant.current_tenant
  end

  def to_s
    email
  end

  def can_receive_payments?
    uid? &&  provider? && access_code? && publishable_key?
  end

  private

  # def after_confirmation
  #   WelcomeMailer.send_greeting(self).deliver_now
  # end

  after_create do
    customer = Stripe::Customer.create(email: self.email)
    update(stripe_customer_id: customer.id)
    self.stripe_customer_id = customer.id
  end
  def user_params
    params.require(:user).permit(:id, :email, :password)
  end

end
