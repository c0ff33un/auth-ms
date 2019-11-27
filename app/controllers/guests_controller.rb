class GuestsController < ApplicationController

  def create
    handle = "guest_#{Time.now.to_i}#{rand(100)}"
    user = User.new
    user.handle = handle
    user.email = "#{handle}@example.com"
    user.password = handle
    user.guest = true
    user.confirm
    user.save!
    if user.valid?
      sign_in(user)
			render json: user, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
  end
  
  def destroy
		user = current_user
    if user.guest
      user.destroy
    end
		if user.destroyed?
			render json: {}, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end
  
end
