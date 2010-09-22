class UsersController < ApplicationController
  
 def index
    @user = User.new
    @posts=Post.all
    @posts = Post.find(:all, :conditions => "posts.user_id IS NOT NULL and posts.user_id != 0")
#     raise @post = Post.find(4).user.user_name.inspect
end


def new
    @user = User.new
end


def create
   
 if params[:user][:user_image]
    
   #upload File Before Creating user    
   name =  params[:user][:user_image].original_filename
   directory = "public/images"
    
    # create the file path
    path = File.join(directory, name)
    
    # write the file ( Copy image )
    File.open(path, "wb") { |f| f.write(params[:user][:user_image].read) }
   
    #get Original File name to store in database and to use in image_tag
    params[:user][:user_image] = params[:user][:user_image].original_filename  
      
 else
   #set default image if user not select image..
   params[:user][:user_image]='avatar.jpg'
 end
   
   #After File Upload Create User
   @user = User.new(params[:user])
      if @user.save
        redirect_to (@user, :notice => 'User was successfully created.')
      else
        render :action => "new" 
    end
    
end
 
def show
   @user=User.find(params[:id])
 end
 
 
 def authenticate
   
   #create new object to retrive data from login form
   @user=User.new(params[:user])
   
   #Find record with username and password
   
   @valid_user=User.find(:first,:conditions => ["user_name = ? and password = ?",@user.user_name, @user.password] )
   
   if @valid_user
     session[:user_id]=@valid_user.id
     session[:user_name]=@valid_user.user_name
     redirect_to ( posts_path )
   else
     flash[:notice] = "Invalid UserName/Password"
     redirect_to :action=> 'index'
   end
end

 def logout
   if session[:user_id]
        reset_session
        redirect_to :action=> 'index'
   end
end
 
end
 
 
