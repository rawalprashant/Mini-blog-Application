class EmailerController < ApplicationController

def sendmail
  @post_id= params[:post_id]
end
  
def getmail
      #hidden field
      post_id = params[:post_id]
      
      recipient = params[:recipient]
      subject = params[:subject]
      message = params[:message]
      
      Emailer.deliver_contact(recipient, subject, message)
     
     return if request.xhr?
            redirect_to post_url(post_id)
            
end

end
