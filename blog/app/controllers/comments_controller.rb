class CommentsController < ApplicationController
  
  before_filter :chksession, :only => [:index, :show, :new, :create, :edit, :update, :destroy]
  
  def index 
    @post = Post.find(params[:post_id])  
    @comments = @post.comments
  end  
  
  def show 
      @post = Post.find(params[:post_id])  
      @comment = @post.comments.find(params[:id])
    
  end  
  
  def new 
      @post = Post.find(params[:post_id])  
      @comment = @post.comments.build 
  end  
  
def create 
      @post = Post.find(params[:post_id])  
      @comment = @post.comments.build(params[:comment])
      @comment.user = @current_user
      
       if @comment.save 
           if request.xhr?    #Ajax Request
                render :update do |page|
                     page.insert_html :bottom, :comments,"<div id='lastcomment#{@comment.id}'><p style='color:#0000FF;'><b>Commenter:</b>#{params[:comment][:commenter]}</p><p style='color:#808000;'><b>Comment:</b>#{params[:comment][:body]}</p></div>"                     
                end
           else
                redirect_to post_comment_url(@post, @comment)
           end  
                
        else  
              render :action => "new"  
        end  
end  
  
def edit 
    @post = Post.find(params[:post_id])  
    @comment = @post.comments.find(params[:id])  
end  
  
def update 
      @post = Post.find(params[:post_id])  
      @comment = Comment.find(params[:id])  
      
      if @comment.update_attributes(params[:comment])  
          redirect_to post_path(@post)  
      else  
          render :action => "edit"  
      end  
end  
  
def destroy 
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])  

    @comment.destroy 
    
      respond_to do |format| 
          format.html { redirect_to post_url(@post) } 
          format.xml { head :ok } 
      end  
end 
  
  private
    def chksession
      if request.xhr? 
          if !session[:user_id]
              render :update do |page|
                     page.replace_html :notlogin, "<p style='color:green;'><b>You are Not Login User..!! Please Login First..Go Back_to_post and login</b></p>"                     
                end
#              redirect_to(:controller => 'users', :action => 'index')
#              flash[:notice]="You are Not Login User..!! Please Login First"
          else
              @current_user = User.find(session[:user_id])
          end
      end
    end

end
