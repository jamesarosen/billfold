Rails.application.routes.draw do

  mount_at = Billfold::Engine.config.mount_at

  post "#{mount_at}auth/:provider/callback" => 'billfold/identities#update_or_create'

  resources :identities, :only => [ :index, :destroy ],
                         :module => 'billfold',
                         :path => "#{mount_at}/identities"

end
