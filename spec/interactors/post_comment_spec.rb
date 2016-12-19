require 'rails_helper'

RSpec.describe PostComment do
  let(:url) { 'http://google.com' }
  let(:repo) { 'samtgarson/github-deploy-bot' }
  let(:pr_number) { 1 }

  subject(:context) do
    PostComment.call(
      repo: repo,
      pull_request_number: pr_number,
      url: url,
      comments: comments
    )
  end

  around(:example) do |example|
    VCR.use_cassette('post_comment') do
      example.run
    end
  end

  describe '#call' do
    context 'with a comment required' do
      let(:comments) { [] }

      it 'is a success' do
        expect(context).to be_a_success
      end

      it 'posts a comment' do
        expect(Octokit).to receive(:add_comment).with(repo, pr_number, /#{url}/)
        context
      end
    end

    context 'with no comment required' do
      let(:comments) { [{ body: "this is the #{url}" }] }

      it 'is a success' do
        expect(context).to be_a_success
      end

      it 'does nothing' do
        expect(Octokit).not_to receive(:add_comment).with(repo, pr_number, /#{url}/)
        context
      end
    end
  end
end
