module ControllerMacros
  def sign_user
    before do
      @user = question.user
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      # question = create(:question)
      # @user = question.user
      sign_in @user
    end
  end

  def sign_another_user
    before do
      @user = create(:user)
      sign_in @user
    end
  end
end
