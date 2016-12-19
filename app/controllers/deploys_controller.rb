class DeploysController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASSWORD']

  def create
    head 200 and return if result.success?
    render json: result.errors, status: 500
  end

  private

    def result
      @result ||= PostComment.call(deploy_params)
    end

    def deploy_params
      params.permit(:repo, :url, :branch)
    end
end
