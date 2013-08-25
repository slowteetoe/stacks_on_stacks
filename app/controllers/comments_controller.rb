class CommentsController < ApplicationController

	def create
		if user_signed_in?
			question = Question.find(params[:q_id])

			if comment_on_question?	
				question.comments << build_comment
				question.save!
				redirect_to question, notice: "Comment submitted!" 
			elsif comment_on_answer?
				answer = question.answers.where(id: params[:a_id]).first
				answer.comments << build_comment
				answer.save!
				redirect_to question, notice: "Comment submitted!" 
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

	def comment_on_question?
		!params[:a_id]
	end

	def comment_on_answer?
		!!params[:a_id]
	end

end
