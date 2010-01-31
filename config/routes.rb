ActionController::Routing::Routes.draw do |map|
  
  map.resources :buckets, :clients
  
  map.with_options :controller => :adjustments do |m|
    m.new_adjustment      '/users/:user_permalink/buckets/:bucket_permalink/adjustments/new.:format', :action => :new,    :conditions => { :method => :get }
    m.connect             '/users/:user_permalink/buckets/:bucket_permalink/adjustments.:format',     :action => :create, :conditions => { :method => :post }
    m.adjustments         '/users/:user_permalink/buckets/:bucket_permalink/adjustments.:format',     :action => :index,  :conditions => { :method => :get }
    m.adjustment          '/users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.:format', :action => :show,   :conditions => { :method => :get }
    m.connect             '/users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.:format', :action => :update, :conditions => { :method => :put }
    m.connect             '/users/:user_permalink/buckets/:bucket_permalink/adjustments/:id.:format', :action => :destroy,:conditions => { :method => :delete }
    m.new_user_adjustment '/users/:user_permalink/adjustments/new',                                   :action => :new,    :conditions => { :method => :get }
    m.connect             '/users/:user_permalink/adjustments',                                       :action => :create, :conditions => { :method => :post }
    m.user_adjustments    '/users/:user_permalink/adjustments.:format',                               :action => :index,  :conditions => { :method => :get }
  end
  
  map.with_options :controller => :dashboards do |d|
    d.home '/', :action => :home, :conditions => { :method => :get }
  end
  
  map.resources :users
  map.user_karma '/users/:id/karma.:format', :controller => :users, :action => :karma, :conditions => { :method => :get  }
  map.root :controller => :dashboards, :action => :home, :conditions => { :method => :get }
end
