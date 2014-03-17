class DashboardController < ApplicationController

  def index
    @blogs = Blog.all
    respond_to do |format|
      format.html
      format.json do
        render json: @blogs.map(&:as_simple_json)
      end
    end
  end

end
