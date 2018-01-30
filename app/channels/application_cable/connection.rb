module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    
    def connect
      self.current_user = env['warden'].user
      reject_unauthorized_connection unless self.current_user
      
      logger.add_tags 'ActionCable', current_user.email
    end
  end
end
