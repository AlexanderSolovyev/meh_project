class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      render json: @answer.to_json(only: [:body], :include => {:attachments => {:only => :file}})
    else
      render json: @answer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @answer = Answer.find(params[:id])
    return unless @answer.user == current_user
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])
    return unless @answer.user == current_user
    @question = @answer.question
    @answer.destroy
  end
  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
