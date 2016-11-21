class SessionController < ApplicationController
  def new
  end

  def create
    binding.pry
    new_user = User.new
    new_user.username = params['username']
    new_user.email = params['email']
    new_user.password = params['password']
    new_user.logged_in = true
    new_user.save
    session[:user_id] = user.id
    binding.pry
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/collection'
    else
      redirect_to '/login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end
end
