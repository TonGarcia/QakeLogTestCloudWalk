require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /importer' do
    it 'returns http success' do
      get '/api/importer'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /report' do
    it 'returns http success' do
      get '/api/report'
      expect(response).to have_http_status(:success)
    end
  end
end
