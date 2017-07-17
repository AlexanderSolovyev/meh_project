require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question){create(:question)}
    context 'with valid attributes' do

      it 'saves the new answer in db' do
        expect{ post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }}.to change(question.answers, :count).by(1) 
      end

      it 'render view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create 
      end
    end

    context 'with invalid attributes' do

      it 'does no save answer' do
        expect{ post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }}.to_not change(question.answers, :count) 
      end

      it 'render show view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
        expect(response).to render_template :create 
      end
    end
  end

end
