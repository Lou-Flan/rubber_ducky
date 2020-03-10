class ConversationsController < ApplicationController
    before_action :authenticate_user!
    
   def index
    recipient = Conversation.where(recipient: current_user)
    @conversations = current_user.conversations + recipient
    # Conversation.where(recipient: current_user) || Conversation.where(sender: current_user) 
    # @messages = @conversations.messages
    #   @messages.each do |conv|
    #     if conv.id.last.read == false then @latest = true end
    #   end
    
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