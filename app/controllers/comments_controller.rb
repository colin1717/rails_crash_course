class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)

		if @comment.save
			redirect_to @post, notice: 'Comment was successfully created.'
		else 
			redirect_to @post, alert: 'Error creating content.' + @comment.errors.full_messages.to_sentence
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		@comment.destroy
		respond_to do |format|
			format.html { redirect_to @post }
			format.json { head :no_content }
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:author, :body, :email)
	end

end
