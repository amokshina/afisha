class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :notfound
  rescue_from Pundit::NotAuthorizedError, with: :notauthorized
  helper_method :current_user
  around_action :switch_locale

  include Pundit::Authorization
  include EventsHelper
  private

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]
    return locale if I18n.available_locales.map(&:to_s).include?(locale)
  end

  def default_url_options # чтобы локаль сохранялась между запросами
    { locale: I18n.locale }
  end

  def notfound(exception)
    logger.warn exception
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def notauthorized
    flash[:danger] = "You don't have the rights to do this"
    redirect_to(request.referer || root_path)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete :user_id
    @current_user = nil
  end

  def require_no_authentication
    return if !user_signed_in?

    flash[:warning] = "You are not signed in!"
    redirect_to root_path
  end

  def require_authentication
    return if user_signed_in?
  end
  helper_method :current_user, :user_signed_in? # благодаря этому можем использовать и в представлениях
end
