class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: login_params[:email])
    password_hash = Digest::MD5.hexdigest(login_params[:password])

    if password_hash == @user.password_digest
      cookies.signed[:login_signed] = @user.id
      redirect_to welcome_index_path
    else
      flash[:message] = "Invalid email or password."
      render 'new'
    end
  end

  def destroy
    cookies.delete :login_signed
    redirect_to welcome_index_path
  end

  private

  def login_params
    params.require(:session).permit(:email, :password)
  end
end
