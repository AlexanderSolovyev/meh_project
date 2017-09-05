class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to questions_path(params[:id])
    else
      render :new
    end
  end

  def update
    return unless @question.user == current_user
    if @question.update_attributes(question_params)
      flash[:notice] = 'Your question successfully updated.'
    end
  end

  def destroy
    return unless @question.user == current_user
    @question.destroy
    flash[:notice] = 'Deleted successfully'
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
