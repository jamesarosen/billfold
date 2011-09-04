Billfold::Engine.routes.draw do

  mount_at = Billfold::Engine.config.mount_at

  post "#{mount_at}auth/:provider/callback" => 'billfold/authentication#update_or_create'

end
