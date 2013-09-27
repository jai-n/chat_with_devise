class MessagesController < ApplicationController
  
  before_filter :validate_user

  
  def index
  	@messages = Message.all
    @users = User.find(:all,:conditions=>['id !=? and status =?',current_user.id,true])
  end

	def create
	  @message = Message.create!(params[:message].permit(:content))
	  PrivatePub.publish_to("/messages/new", message: @message)
	# PrivatePub.publish_to("/messages/new", "alert('#{@message.content}');")
	end
	private

  def validate_user() #might need to pass id and current_user
    unless current_user     
      flash[:error] = "Please sign in before access this chating"
      redirect_to new_user_session_path
  	end
  end
end
