class CommentsController < ApplicationController

  def create
  	if user_signed_in?
	  	if on_question?
				@question = Question.find(params[:question_id])
				@comment = @question.comments.build(comment_params)
				@comment.author = current_user.username
				@comment.save!
				redirect_to @question, notice: "Comment submitted!" 
			elsif on_answer?
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
    params.require(:comment).permit(:body, :parent)
  end

  def on_question?
  	params[:comment][:parent] == 'question'
  end

  def on_answer?
  	params[:comment][:parent] == 'answer'
  end

end
