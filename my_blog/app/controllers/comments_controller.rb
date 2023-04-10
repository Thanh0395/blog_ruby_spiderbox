class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.create(:commenter => params[:comment][:commenter], :body => params[:comment][:body], :post_id => params[:post_id])
        redirect_to post_path(@post)
    end
    
    def show
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to post_path(@post), notice: "Comment was successfully destroyed." }
            format.json { render json: @post.errors, status: :unprocessable_entity }
        end
    end

     # PATCH/PUT /comments/1 or /comments/1.json
    def update
        respond_to do |format|
            if @comment.update(comment_params)
                format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
                format.json { render :show, status: :ok, location: @comment }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        # post_id = @comment.post.post_id
        @comment.destroy
        # redirect_to post_path(@post)
        render :nothing => true, :status => 204
        # respond_to do |format|
        #     format.html { redirect_to post_path(@post), notice: "Comment was successfully destroyed." }
        #     format.json { render json: @post.errors, status: :unprocessable_entity }
        # end
    end
    
    private
        def comment_params
            params.require(:comment).permit(:commenter, :body, :post_id)
        end
end
