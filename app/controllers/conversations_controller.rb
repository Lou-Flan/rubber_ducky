class ConversationsController < ApplicationController
    before_action :authenticate_user!
    
   def index
    recipient = Conversation.where(recipient: current_user)
    @conversations = current_user.conversations + recipient

  end

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