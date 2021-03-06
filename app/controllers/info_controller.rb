class InfoController < ApplicationController
  layout 'styleguide_css', :only => [:styleguide]

  def marketing
    @recent_courses = Course.where(public: true).limit(3).order('id desc')
    @user = User.new
    session[:return_to] = request.url
  end

  def styleguide
    @styleguide = Kss::Parser.new("app/assets/stylesheets")
    if not params[:ref]
      render :template => "info/styleguide/css/index"
      return
    end

    case params[:ref].to_i
    when 1.0
      render :template => "info/styleguide/css/buttons"
    when 2.0
      render :template => "info/styleguide/css/colors"
    when 3.0
      render :template => "info/styleguide/css/comments"
    when 4.0
      render :template => "info/styleguide/css/menus"
    end
  end

  def set_locale
    cookies.permanent[:locale] = params[:locale]
    redirect_to_target_or_default :root
  end
end

