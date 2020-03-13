class ConversationsController < ApplicationController
    before_action :authenticate_user!

#-----------------------------------------------------------------------
# checks conversation relation and returns all conversations where the 
# current user is either the sender or the recipient
#-----------------------------------------------------------------------  
  def index
    recipient = Conversation.where(recipient: current_user)
    @conversations = current_user.conversations + recipient
  end

#-----------------------------------------------------------------------
# checks if a conversation is present by parsing params of sender & 
# recipient ids, if so it selects the first conversation to use to add
# messages to. if not, a new conversation is created and a row added to 
# conversations table.
#-----------------------------------------------------------------------  

  def create
      if Conversation.between(params[:sender_id],params[:recipient_id])
        .present?
        @conversation = Conversation.between(params[:sender_id],
          params[:recipient_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end
    redirect_to conversation_messages_path(@conversation)
  end

private
    def conversation_params
     params.permit(:sender_id, :recipient_id)
    end
end