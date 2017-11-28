Rails.application.routes.draw do
	post 'user_token' => 'user_token#create'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get 'course/all', to: 'course#all'
	get 'course/:id', to: 'course#show'
	post 'course/:id/like', to: 'course#like'
	post 'course/:id/comment', to: 'course#comment'

	resource :user, only: [:create]

	get '*path', to: 'application#fallback_index_html', constraints: lambda { |request|
		!request.xhr? && request.format.html?
	}
end
