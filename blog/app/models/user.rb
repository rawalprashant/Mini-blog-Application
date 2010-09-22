
require "digest/md5"

class User < ActiveRecord::Base
  
    has_many :posts
    has_many :comments
 
 validates_presence_of(:first_name,:last_name,:user_name,:password,:mobile_no,:email)
 validates_uniqueness_of :user_name
 validates_numericality_of :mobile_no
 validates_format_of :email,
                    :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                    :message => "Address is not a valid id..!"
 



 def password=(password)
    write_attribute :password, Digest::MD5.hexdigest( password )
 end
   
end
