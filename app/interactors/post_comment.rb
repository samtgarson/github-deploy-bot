class PostComment
  include Interactor

  def call
    return unless comment_required?
    success = post_comment!
    context.fail!(error: 'Something went wrong') unless success
  end

  private

    def post_comment!
      Octokit.add_comment(context.repo, context.pull_request_number, message)
    end

    def message
      @message ||= context.message || "**Deployed to:**\n#{context.url}"
    end

    def comment_required?
      context.comments.none? { |c| c[:body][/#{context.url}/] }
    end
end
