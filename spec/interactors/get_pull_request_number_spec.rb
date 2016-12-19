require 'rails_helper'

RSpec.describe GetPullRequestNumber do
  let(:repo) { 'samtgarson/github-deploy-bot' }
  let(:branch) { 'github-pr' }

  subject(:context) do
    GetPullRequestNumber.call(
      repo: repo,
      branch: branch
    )
  end

  around(:example) do |example|
    VCR.use_cassette('pull_request_number') do
      example.run
    end
  end

  describe '#call' do
    it 'is a success' do
      expect(context).to be_a_success
    end

    it 'posts a comment' do
      expect(context.pull_request_number).to eq 1
    end
  end
end
