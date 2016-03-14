class LinksController < ApplicationController
  def show
    @url = Url.find_by(short_url: params[:short])

    redirect_to @url.full_url

  end
end
