class PostComment
  include Interactor

  def call
    success = post_comment!
    context.fail!(error: 'Something went wrong') unless success
  end

  private

    def pull_requests
      @pull_requests ||= Octokit.pull_requests(context.repo, state: 'open')
    end

    def pull_request
      @issue ||= pull_requests.detect { |pr| pr[:head][:ref] == context.branch }
    end

    def post_comment!
      Octokit.add_comment(context.repo, pull_request[:number], message)
    end

    def message
      @message ||= context.message || "**Deployed to:**\n#{context.url}"
    end
end
