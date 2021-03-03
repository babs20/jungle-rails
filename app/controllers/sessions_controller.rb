class SessionsController < ApplicationController
  def new; end
  def create
    user = User.find_by_email(user_params[:email])

    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
