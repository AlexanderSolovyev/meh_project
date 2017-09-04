require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  describe 'Get#index' do
    let(:questions) { create_list(:question, 2) }

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

  sign_user
  describe 'Get#new' do
    it 'build new question' do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'Post#create' do
    context 'with valid arguments' do
      it 'record db to db' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirect to #index' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to questions_path(assigns(Question.last))
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
      it 'dont change attributes' do
        patch :update, params: {id: question, question: attributes_for(:invalid_question), format: :js}
        question.reload
        expect(question.body).to eq('MyString')
        expect(question.title).to eq('MyString')
      end

    end
  end

  describe 'Put#destroy' do
    before { question }

    it 'destroy question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it ' redirect to index' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
