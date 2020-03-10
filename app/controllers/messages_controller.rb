class MessagesController < ApplicationController
  before_action :authenticate_user!
  
    before_action do
     @conversation = Conversation.find(params[:conversation_id])
    end

    def index
    @messages = @conversation.messages
    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)
      
      if @conversation.sender == current_user
        @you = @conversation.sender
        @them = @conversation.recipient
      else
        @you = @conversation.recipient
        @them = @conversation.sender
      end

#-----------------------------------------------------------------------
# authorisation to prevent users viewing other users conversation. 
#-----------------------------------------------------------------------  
      if current_user != (@conversation.sender || @conversation.recipient)
        redirect_to conversations_path
      end

      @message = @conversation.messages.new
    end

    def create
      @message = @conversation.messages.new(message_params)
      @message.user = current_user
  
      if @message.errors.any?
        render "index"
      elsif @message.save
        redirect_to conversation_messages_path(@conversation)
      end
    end
    
    private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
  end