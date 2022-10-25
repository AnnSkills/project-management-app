class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def index
    @accounts = Account.all
    # if user_signed_in?
    #   @accounts = Account.all
    # end
  end
  def create
    @account = Account.new(account_params)
    @account= current_user.accounts.build(account_params)
    @account.users << current_user

    respond_to do |format|
      if @account.save
        format.html { redirect_to root_path, notice: 'Organisation was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @accounts = Account.all
  end

  def new
    @account = current_user.account
    @user = current_user
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Organisation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:id, users_attributes: [:id, :name, :email])
    #params[:account].permit(:id)
  end
end
