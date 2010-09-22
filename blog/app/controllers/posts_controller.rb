class PostsController < ApplicationController
  
  #Rails runs before filters before any action in the controller posts.
  before_filter :find_user,
                :only => [:new, :show, :create, :edit, :update, :destroy]
  
def index
    #Listing Login User Posts
     @user = User.find(session[:user_id])
     @user.user_image #accessing image
     
     # Post For login user
     @user_posts = @user.posts


    unless params[:commit].blank?
        #select * from posts where title like "%"
        if params[:search_name] && params[:search_type]=='title'
           @post=Post.find(:all, :conditions => ["title like ?", params[:search_name]+'%'])
           @post=@post.paginate (:per_page => 2, :page => params[:page])
        
        elsif params[:search_name] && params[:search_type]=='username'
           #select * from posts left join users on users.id = posts.user_id where user_name like "%prashant%";
           @post= Post.find(:all,  :joins => "LEFT JOIN users ON users.id = posts.user_id", :conditions => ["user_name like ?", params[:search_name]+'%' ] )
           @post=@post.paginate (:per_page => 2, :page => params[:page])
        end
    else
      #Listing All Other User Posts
      @post = Post.find(:all, :conditions => "posts.user_id IS NOT NULL and posts.user_id != 0", :order => 'created_at DESC')
#      @post = Post.paginate (:per_page => 4, :page => params[:page]) 
      @post = @post - @user_posts
      @post = @post.paginate({:page => params[:page], :per_page => 4})
    end
          respond_to do |format|
             format.html # index.html.erb
             format.xml  { render :xml => @posts }
          end
end

  
def show
      @post=Post.find(params[:id])
      @comment = @post.comments.build #this means comments.new for post.id
      
      @comments = @post.comments
      
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
      
    end
end

  
def new
    @post = @user.posts.build 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
end

  
def edit
     @post = @user.posts.find(params[:id])
end

  
def create
     @post = @user.posts.build(params[:post])  

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
end

  
def update
     @post = Post.find(params[:id])
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
end

  
def destroy
    
    @post = Post.find(params[:id])  
    @post.destroy 

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
end
  
  
private 
def find_user
      if session[:user_id]
        @user = User.find(session[:user_id])
      end
end

end
