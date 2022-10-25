class Account < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :users
  accepts_nested_attributes_for :users, allow_destroy: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  # belongs_to :user
  def acc_params
    params.require(:account).permit(:id, :user_id)
  end
end
