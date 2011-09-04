Rails.application.routes.draw do |map|

  mount_at = Billfold::Engine.config.mount_at

  post 'auth/:provider/callback' => 'billfold/authentication#update_or_create'

end
