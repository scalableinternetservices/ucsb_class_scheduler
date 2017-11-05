Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get 'course/all', to: 'course#all'

	get '*path', to: 'application#fallback_index_html', constraints: lambda { |request|
		!request.xhr? && request.format.html?
	}
end
