class PostsController < ApplicationController
    def index
        @posts = Post.all
    end
    
    def new
        @post = Post.new
    end
    
    def create
        if @post = Post.create(post_params)
            flash[:success] = "Successful Upload"
            redirect_to posts_path
        else
            flash[:danger] = "Upload Failed"
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
