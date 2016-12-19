class DeploysController < ApplicationController
  def create
    head 200 and return if result.success?
    render json: result.errors, status: 500
  end

  private

    def result
      @result ||= ProcessDeployment.call(deploy_params)
    end

    def deploy_params
      params.permit(:repo, :url, :branch)
    end
end
