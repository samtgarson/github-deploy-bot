class GetExistingComments
  include Interactor

  def call
    context.comments = relevant_comments if context.pull_request_number
  end

  private

    def relevant_comments
      comments.select { |c| c[:user][:login] == ENV['GITHUB_USER'] }
    end

    def comments
      @comments ||= Octokit.issue_comments(context.repo, context.pull_request_number)
    end
end
