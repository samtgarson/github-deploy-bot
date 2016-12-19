require 'rails_helper'

RSpec.describe DeploysController, type: :controller do
  let(:url) { 'http://google.com' }
  let(:branch) { 'github-pr' }
  let(:repo) { 'samtgarson/github-deploy-bot' }
  let(:pr_number) { 1 }

  describe 'GET #create' do
    around(:all) do |example|
      VCR.use_cassette('post_comment') do
        VCR.use_cassette('pull_request_comments') do
          VCR.use_cassette('pull_request_number') do
            example.run
          end
        end
      end
    end

    before do
      http_login
    end

    it 'posts a comment successfully' do
      expect(Octokit).to receive(:add_comment).with(repo, pr_number, /#{url}/).and_return true

      post :create, params: { repo: repo, branch: branch, url: url }

      expect(response).to have_http_status(:success)
    end
  end
end
