# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :mortgages, only: %i[create update show index] do
      end
    end
  end
end
