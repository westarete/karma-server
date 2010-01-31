# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :api_key

  before_filter :require_login

  def require_login
    respond_to do |format|
      format.html { true }
      format.json { require_client_login }
      format.xml  { require_client_login }
    end
    true
  end
  
  def current_user
    @current_user
  end
  
  protected
  
  def require_client_login
    client = Client.find_by_ip_address(request.env['REMOTE_ADDR'])
    authenticate_or_request_with_http_basic do |username, password|
      if client && username == '' && password == client.api_key
        @current_user = client
      else
        @current_user = nil
      end
    end
  end
  
  def rescue_action(exception)
    case exception
    when ActiveRecord::RecordNotFound, ActionController::RoutingError
      render_404
    else
      super
    end
  end
  
  def render_404
    respond_to do |format|
      format.html { render :file => "#{RAILS_ROOT}/public/404.html", :status => :not_found }
      format.json { render :nothing => true, :status => :not_found }
      format.xml  { render :nothing => true, :status => :not_found }
    end
    true
  end

end

