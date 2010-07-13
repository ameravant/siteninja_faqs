resources :faqs
namespace :admin do |admin|
  admin.resources :faqs, :member => { :reorder => :put }
end 
