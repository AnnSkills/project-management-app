class Account < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :users
  accepts_nested_attributes_for :users, allow_destroy: true
<<<<<<< HEAD
  devise :invitable, :database_authenticatable, :registerable,
=======
  devise :database_authenticatable, :registerable,
>>>>>>> new
         :recoverable, :rememberable, :validatable,
         :confirmable

  def acc_params
    params.require(:account).permit(:id, :users_id)
  end
end
