class Comment < ActiveRecord::Base
  
  #make one-to-one relationship wiht posts table
  belongs_to :post
  belongs_to :user

  
  



end
