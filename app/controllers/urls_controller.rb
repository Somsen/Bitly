class UrlsController < ApplicationController
  def index
    @urls = Url.all
  end

  def show
    @url = Url.find(params[:id])
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(urls_params)

    if @url.save
      redirect_to @url
    else
      render 'new'
    end
  end

  def destroy
    @url = Url.find(params[:id])
    @url.destroy

    redirect_to urls_path
  end

  private
    def urls_params
      params.require(:url).permit(:full_url)
    end

end
