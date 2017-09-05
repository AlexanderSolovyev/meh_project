module ControllerMacros
  def sign_user
    before do
      #@user = create(:user)
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      #sign_in @user
      question = create(:question)
      @user = question.user
      sign_in @user
    end
  end
end
