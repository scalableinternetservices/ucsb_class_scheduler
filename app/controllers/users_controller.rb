class UsersController < ApplicationController
	def create
		create_user
	rescue ActiveRecord::RecordInvalid
		return render json: user.errors, status: 400
	rescue ActiveRecord::RecordNotUnique
		return render json: { email: 'already exists' }, status: 400
	end

		private

	def create_user
		if params[:email].empty? || params[:password].empty?
			render json: { status: 'failed' }, status: 400
		else
			user = User.create!(email: params[:email], password: params[:password])
			render json: user
		end
	end
end
