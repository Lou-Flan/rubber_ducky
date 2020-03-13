class MessagesController < ApplicationController
  before_action :authenticate_user!
  
    before_action do
     @conversation = Conversation.find(params[:conversation_id])
    end

#-----------------------------------------------------------------------
# finds all conversation messages. queries db message table for rows where
# FK user_id(message sender) doesn't match the current user id and the bool
# for read column is false - when on the message index page, the bool value
# for these messages is then updated to true. 
#----------------------------------------------------------------------- 
    def index
    @messages = @conversation.messages
    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)

#-----------------------------------------------------------------------
# sets variables to use within views and reduce view logic 
#-----------------------------------------------------------------------  
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
      if current_user != @conversation.sender 
        if current_user != @conversation.recipient
        redirect_to conversations_path
        end
      end

      @message = @conversation.messages.new
    end

#-----------------------------------------------------------------------
# creates a new message linked to the current conversation id. takes :body and
# :user id params to add data to the message table in correct attributes.
#-----------------------------------------------------------------------  
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