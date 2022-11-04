class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def create
    @account = Account.new(account_params)
    @account = current_user.accounts.build(account_params)
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

  def show; end

  def new
    @account = current_user.account
    @user = current_user
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to account_session_url, notice: 'Organisation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def account_params
    params.require(:account).permit(:id, users_attributes: [:id, :name, :email])
  end
end
