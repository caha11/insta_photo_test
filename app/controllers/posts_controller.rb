class PostsController < ApplicationController
    # before_action :authenticate_user!
    
    def index
        @posts = Post.all
    end
    
    def new
        if user_signed_in?
            @post = current_user.posts.build
        else
            @post = Post.new
        end
    end
    
    def create
        if user_signed_in?
            @post = current_user.posts.build(post_params)
            
            if @post.save
                flash[:success] = "Successful Upload"
                redirect_to posts_path
            else
                flash[:danger] = "Upload Failed"
                render :new
            end
        else
            if @post = Post.create(post_params)
              flash[:success] = "Your post has been created!"
              redirect_to posts_path
            else
              flash.now[:alert] = "Your new post couldn't be created!  Please check the form."
              render :new
            end
        end
    end
    
    def destroy  
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to root_path
    end
    
    def post_params
        params.require(:post).permit(:image, :caption)
    end
end
