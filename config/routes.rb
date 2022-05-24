Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/api' do
    get 'importer' => 'home#importer'
    get 'exporter' => 'home#exporter'
    get 'report' => 'home#report'
  end
end
