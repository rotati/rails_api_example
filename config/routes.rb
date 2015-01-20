Rails.application.routes.draw do
  constraints subdomain: 'api' do
    resources :properties do
    end
  end
end
