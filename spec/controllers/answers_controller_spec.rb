require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) {create(:question, user: user)}
  let(:user) { create(:user) }
  let(:user2) {create(:user)}
  describe 'POST #create' do
    context 'with valid attributes' do
      example 'unregistered user cant saves answer' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response.body).to include 'You need to sign in or sign up before continuing.'
      end

      before {question}
      it 'saves the new answer in db' do
        sign_in user
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js } }.to change(question.answers, :count).by(1)
      end

      it 'render view' do
        sign_in user
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      before { sign_in user }

      it 'does no save answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js } }.to_not change(question.answers, :count)
      end

      it 'render show view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end
  end

  let(:answer) {create(:answer, question: question, user: user)}
  describe 'PATH#update' do
    it 'assign the requested answer to answer' do
      sign_in user
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(answer).to eq answer
    end
    it 'assign question' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(question).to eq answer.question
    end
    it 'changes answer attributes' do
      sign_in user
      patch :update, params: {id: answer, question_id: question, answer: {body: 'edited answer'}, format: :js}
      answer.reload
      expect(answer.body).to eq('edited answer')
    end
    it 'try changes other users answer attributes' do
      answer
      sign_in user2
      patch :update, params: { id: answer, question_id: question, answer: { body: 'edited answer' }, format: :js }
      answer.reload
      expect(answer.body).to eq('MyAnswer')
    end
    describe 'Delete#destroy' do
      it 'assign question' do
        delete :destroy, params: { id: answer, question_id: question, format: :js }
        expect(question).to eq answer.question
      end
      it 'assign answer' do
        delete :destroy, params: { id: answer, question_id: question, format: :js }
        expect(answer).to eq answer
      end
      it 'destroy answer' do
        answer
        sign_in user
        expect { delete :destroy, params: { id: answer, question_id: question, format: :js } }.to change(Answer, :count)
      end
      it 'try to destroy another user answer' do
        answer
        sign_in user2
        expect {delete :destroy, params: {id: answer, question_id: question, format: :js}}.to_not change(Answer, :count)
      end
    end
  end
end
