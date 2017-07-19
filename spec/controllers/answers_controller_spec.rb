require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question){create(:question)}
  let(:user){ create(:user) }
  describe 'POST #create' do
    
    context 'with valid attributes' do
      example 'unregistered user cant saves answer' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response.body).to include 'You need to sign in or sign up before continuing.'
      end

      it 'saves the new answer in db' do
        sign_in user
        expect{ post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }}.to change(question.answers, :count).by(1) 
      end

      it 'render view' do
        sign_in user
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create 
      end
    end

    context 'with invalid attributes' do
      before{sign_in user}

      it 'does no save answer' do
        expect{ post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }}.to_not change(question.answers, :count) 
      end

      it 'render show view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
        expect(response).to render_template :create 
      end
    end
  end

  let(:answer){ create(:answer, question: question)}
  describe 'PATH#update' do

    it 'assign the requested answer to answer' do
    patch :update, params: {id: answer, question_id: question, answer: attributes_for(:answer), format: :js}
    expect(answer).to eq answer
    end
    it 'assign question'
    it 'changes answer attributes'
  end

end
