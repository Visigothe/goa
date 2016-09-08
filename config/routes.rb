Rails.application.routes.draw do
  get 'components' => 'high_voltage/pages#show', id: 'components'
end
