class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def create
        @comment = Comment.new(comment_params)
        @comment.account_id = current_account.id

        respond_to do |format|
            if @comment.save
                @comments = Comment.where(post_id: @comment.post_id)
                format.js { render "comments/create" }
            else
                # unable to save
            end
        end
    end

    def comment_params
        params.require(:comment).permit(:message, :post_id)
    end
end