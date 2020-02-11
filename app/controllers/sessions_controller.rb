# frozen_string_literal: true

# Class responsible for managing user sessions 
class SessionsController < ApplicationController
  before_action :set_user, only: :create

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def set_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end
end
