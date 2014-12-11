Jekylly::Engine.routes.draw do

  # Lowest priority route glob goes to static controller
  get '*path' => 'static#show'
  
end
