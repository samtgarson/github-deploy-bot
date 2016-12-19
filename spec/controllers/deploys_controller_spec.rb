require 'rails_helper'

RSpec.describe DeploysController, type: :controller do
  let(:url) { 'http://google.com' }
  let(:branch) { 'github-pr' }
  let(:repo) { 'samtgarson/github-deploy-bot' }

  describe 'GET #create' do
    around(:example) do |example|
      VCR.use_cassette('pull_request') do
        example.run
      end
    end

    it 'returns posts a comment successfully' do
      expect(PostComment).to receive(:call).and_return instance_double('Interactor::Context', success?: true)

      post :create, params: { repo: repo, branch: branch, url: url }

      expect(response).to have_http_status(:success)
    end
  end
end
