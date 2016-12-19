require 'rails_helper'

RSpec.describe GetExistingComments do
  let(:repo) { 'samtgarson/github-deploy-bot' }
  let(:pr_number) { 1 }

  subject(:context) do
    GetExistingComments.call(
      repo: repo,
      pull_request_number: pr_number
    )
  end

  around(:example) do |example|
    VCR.use_cassette('pull_request_comments') do
      example.run
    end
  end

  describe '#call' do
    it 'is a success' do
      expect(context).to be_a_success
    end

    it 'gets its own comments' do
      # The VCR cassette a comment by another user as well
      expect(context.comments.size).to eq 1
    end
  end
end
