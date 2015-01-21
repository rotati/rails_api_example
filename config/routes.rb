Rails.application.routes.draw do
  constraints subdomain: 'api' do
    resources :properties do
      collection do
        get :exclusive
      end
    end
  end
end
