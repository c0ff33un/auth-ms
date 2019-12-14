class UsersController < ApplicationController
	#before_action :authenticate_user!
	def index
		user = User.all
		render json: users, status: :ok
	end

	def show
		user = current_user
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
		user = current_user
		if user.update(edit_params) && user.guest == false
			render json: user, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end
	
	def resend_confirmation
		user = User.find_by(:email => user_params[:email])
		if user
			if user.confirmed?
				render json: {errors:{email:["User already confirmed"]}}, status: :unprocessable_entity
			else
				user.send_confirmation_instructions
				render json: user, status: :ok
			end
		else
			render json: {errors:{email:["User not found"]}}, status: :not_found
		end
	end
	private
    def user_params
			params.require(:user).permit(:email, :handle, :password)
		end
		def edit_params
			params.require(:user).permit(:email, :handle)
    end
end
