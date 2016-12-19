class ProcessDeployment
  include Interactor::Organizer

  organize GetPullRequestNumber, GetExistingComments, PostComment
end
