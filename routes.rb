resources :faqs, :member => { :tag => :get }
namespace :admin do |admin|
  admin.resources :faqs, :member => { :reorder => :put }, :collection => { :update_positions => :put }
end 
