class Message < ActiveRecord::Base
    belongs_to :conversation
    belongs_to :user
    validates_presence_of :body, :conversation_id, :user_id

    before_validation :sanitize_message_inputs, on: [:new, :create, :update, :edit]


#-----------------------------------------------------------------------
# sanitizes input and removes any illegal characters from the message body
# before saving to database
#-----------------------------------------------------------------------
private    
    def sanitize_message_inputs
        self.body.gsub!(/[^0-9A-Za-z ,.'!"]/, '')
    end
    
end