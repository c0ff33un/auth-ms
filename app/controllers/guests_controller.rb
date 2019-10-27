class GuestsController < ApplicationController

  def create
    handle = "guest_#{Time.now.to_i}#{rand(100)}"
    user = User.create(
      handle: handle,
      email: "#{handle}@example.com",
      password: handle,
      guest: true
    )
    user.confirm
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
