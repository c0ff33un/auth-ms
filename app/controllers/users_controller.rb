class UsersController < ApplicationController
  allowed
	def index
		user = User.all
		render json: users, status: :ok
	end

	def show
		user = User.find(params[:id])
		if user.valid?
			render json: user, status: :ok
		else
			render json: user.errors, status: :not_found
		end
	end

  def create
    user = User.create(user_params)
    if user.valid?
			render json: user, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			render json: user, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		if user.destroyed?
			render json: {}, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end
    
	private
    def user_params
			params.require(:user).permit(:name, :email, :handle, :password)
    end
end
