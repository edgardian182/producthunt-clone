class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_in(user)
    # Creamos una cookie (Información plantada en el navegador del usuario)
    cookies.permanent.signed[:user_id] = user.id
    @current_user = user
  end

  def sign_out
    cookies.delete(:user_id)
    @current_user = nil
  end

  private
    # Saber si usuario autenticado
    def signed_in?
      !current_user.nil?
    end
    helper_method :signed_in? # Permite llamar el metodo desde las vistas

    # Permite saber el usuario que esta autenticado
    def current_user
      @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
    rescue ActiveRecord::RecordNotFound
    end
    helper_method :current_user

    def private_access
      redirect_to :login unless signed_in?
    end

    def public_access
      redirect_to root_path if signed_in?
    end
end
