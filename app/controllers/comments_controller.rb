class CommentsController < ApplicationController

  def create
  	if user_signed_in?
	  	if !!params[:q_id]
				@question = Question.find(params[:q_id])
				@question.comments << build_comment
				@question.save!
				redirect_to @question, notice: "Comment submitted!" 
			elsif !!params[:a_id]
				# do stuff
			else
				redirect_to '/', notice: "Not so much." 
			end
		else
			redirect_to '/users/sign_in', alert: "You need to sign in or sign up before continuing."
		end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :q_id, :a_id)
  end

  def build_comment
  	Comment.new(body: params[:body], author: current_user.username)
  end

end
