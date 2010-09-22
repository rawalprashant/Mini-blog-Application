class Emailer < ActionMailer::Base
    
      def contact(recipient, subject, message, sent_at = Time.now)
          @subject = subject
          @recipients = recipient
          @from = 'prashant.rawal@radixweb.com'
          @sent_on = sent_at
              @body["title"] = 'This is title'
              @body["email"] = 'prashant.rawal@radixweb.local'
              @body["message"] = message
          @headers = {}

   end


end
