class SessionsController < ApplicationController
  skip_before_action :ensure_user_login, only: [:new, :create]

  def new
    # Login page template => new.html.erb
  end

  def create
    reviewer_name = Reviewer.find_by(name: params[:reviewer][:name])
    reviewer_password = params[:reviewer][:password]

    if reviewer_name && reviewer_name.authenticate(reviewer_password)
      #session[] here is a hash accessor like params - this line puts the reviewer id into the session hash
      session[:reviewer_id] = reviewer_name.id
      redirect_to root_path, notice: "Logged in." #get me the index page (which is already in the root directory)
    else
      redirect_to login_path, alert: "Invalid Login Password/Username" #reload the loginpage again with the alert message
    end
  end

  def destroy
    reset_session #wipe out session and everything in it (end the connection)
    redirect_to login_path, notice: "you have been logged out."
  end
end
