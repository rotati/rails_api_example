Rails.application.routes.draw do
  scope defaults: { format: :json} do
    constraints subdomain: 'api' do
      namespace :v1 do
        resources :properties do
          collection do
            get :ping
          end
        end
      end

      namespace :v2 do
        resources :properties do
          collection do
            get :ping
          end
        end
      end
    end
  end
end
