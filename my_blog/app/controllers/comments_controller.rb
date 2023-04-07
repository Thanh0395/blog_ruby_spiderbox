class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.create(:commenter => params[:comment][:commenter], :body => params[:comment][:body], :post_id => params[:post_id])
        redirect_to post_path(@post)
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end
    
    private
        def comment_params
            params.require(:comment).permit(:commenter, :body, :post_id)
        end
end
