class MessagesController < ApplicationController
  
  before_filter :validate_user

  
  def index
  	@messages = Message.all
  	authorize! :manage, current_user
  end

	def create
	  @message = Message.create!(params[:message].permit(:content))
	  PrivatePub.publish_to("/messages/new", message: @message)
	# PrivatePub.publish_to("/messages/new", "alert('#{@message.content}');")
		authorize! :manage, current_user
	end
	private

  def validate_user() #might need to pass id and current_user
    unless current_user     
      flash[:error] = "Please sign in before access this chating"
      redirect_to new_user_session_path
  	end
  end
end
