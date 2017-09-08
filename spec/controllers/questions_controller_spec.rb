require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) {create(:user)}
  let(:question) {create(:question, user: user)}
  describe 'Get#index' do
    let(:questions) {create_list(:question, 2, user: user)}

    it 'select all questions' do
      get :index
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'Get#show' do
    before { get :show, params: { id: question } }

    it 'select question from db' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'Get#new' do
    sign_user

    before {get :new}
    it 'build new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new template' do
      expect(response).to render_template :new
    end
    it 'bild new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end
  end

  describe 'Post#create' do
    sign_user
    context 'with valid/users/sign_out arguments' do
      it 'record d/users/sign_outb to db' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirect to #show' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(Question.last)
      end
    end

    context 'with invalid arguments' do
      it 'dont record in db' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.not_to change(Question, :count)
      end

      it 'render to new_path' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end
  describe 'Patch#update' do
    context 'with valid attributes' do
      sign_user
      it 'search question' do
        patch :update, params: {id: question, question: attributes_for(:question), format: :js}
        expect(assigns(:question)).to eq question
      end

      it 'change attributes' do
        patch :update, params: {id: question, question: {title: 'new title', body: 'new body'}, format: :js}
        question.reload
        expect(question.body).to eq('new body')
        expect(question.title).to eq('new title')
      end
    end

    context 'with invalid attributes' do
      sign_user
      it 'dont change attributes' do
        patch :update, params: {id: question, question: attributes_for(:invalid_question), format: :js}
        question.reload
        expect(question.body).to eq('MyString')
        expect(question.title).to eq('MyString')
      end
    end

    context 'another user try update question' do
      sign_another_user
      it 'dont change attributes' do
        patch :update, params: {id: question, question: {title: 'new title', body: 'new body'}, format: :js}
        question.reload
        expect(question.body).to eq('MyString')
        expect(question.title).to eq('MyString')
      end
    end
  end

  describe 'Put#destroy' do
    before { question }
    context 'authenticate user' do
      sign_user

      it 'destroy his question' do
        expect {delete :destroy, params: {id: question}}.to change(Question, :count).by(-1)
      end

      it ' redirect to index' do
        delete :destroy, params: {id: question}
        expect(response).to redirect_to questions_path
      end
    end
    context 'another user ' do
      sign_another_user
      it 'try destroy other user question' do
        expect {delete :destroy, params: {id: question}}.to_not change(Question, :count)
      end
    end
  end
end
