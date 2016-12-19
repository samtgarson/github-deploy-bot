class GetPullRequestNumber
  include Interactor

  def call
    context.pull_request_number = pull_request.number if pull_request
  end

  private

    def pull_requests
      @pull_requests ||= Octokit.pull_requests(context.repo, state: 'open')
    end

    def pull_request
      @pull_request ||= pull_requests.detect { |pr| pr[:head][:ref] == context.branch } if pull_requests.any?
    end
end
