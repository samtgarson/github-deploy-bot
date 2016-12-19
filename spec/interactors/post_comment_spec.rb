require 'rails_helper'

RSpec.describe PostComment do
  let(:url) { 'http://google.com' }
  let(:branch) { 'github-pr' }
  let(:repo) { 'samtgarson/github-deploy-bot' }
  let(:pr_number) { 1 }

  subject(:context) do
    PostComment.call(
      repo: repo,
      branch: branch,
      url: url
    )
  end

  around(:example) do |example|
    VCR.use_cassette('pull_request') do
      example.run
    end
  end

  describe '#call' do
    it 'is a success' do
      expect(context).to be_a_success
    end

    it 'posts a comment' do
      expect(Octokit).to receive(:add_comment).with(repo, pr_number, /#{url}/)
      context
    end
  end
end
