Rails.application.routes.draw do
  scope "(:locale)" do /#{I18n.available_locales.join("|")}/  # localhost/events localhost/en/events
    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update]

    resources :events do
      resources :comments, only: %i[create destroy edit update] # вложенные маршруты
    end

    resources :events do
      member do
        post 'register'
      end
    end

    resources :events do
      member do
        delete 'remove_registration', to: 'events#remove_registration'
      end
    end

    namespace :admin do
      resources :users, only: %i[index edit update destroy]
    end

    root "pages#index"
  end
end