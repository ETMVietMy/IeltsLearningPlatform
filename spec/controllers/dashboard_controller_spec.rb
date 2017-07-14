require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #register_teacher" do
    it "returns http success" do
      get :register_teacher
      expect(response).to have_http_status(:success)
    end
  end

end
