class ConversationsController < ApplicationController
    before_action :authenticate_user!
    
   def index
    @conversations = Conversation.all

    # @users = @conversations.each do |conv|
    #     if conv.sender == current_user
    #       link_to conv.recipient.username, conversation_messages_path(conv)
    #     else
    #       link_to conv.sender.username, conversation_messages_path(conv)
    #     end
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