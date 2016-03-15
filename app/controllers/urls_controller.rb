class UrlsController < ApplicationController

  before_action :require_login

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

    if Url.full_url_already_shortened?(urls_params[:full_url])
      @url = Url.find_by(full_url: urls_params[:full_url])
      redirect_to @url
    else
      @url = Url.new(urls_params)
      if @url.save
        # errors.full_messages
        # 
        redirect_to @url
      else
        # IN CASE OF ERROR, VALIDATE THE KIND OF ERROR AND IF THE CASE WAS THE UNIQUENESS VALIDATION
        # FIND THE EXISTING REFERENCE
        # @url_db = Url.where(full_url: urls_params[:full_url]).first

        # if @url_db.nil?
          render 'new'
        # else
        #   redirect_to @url_db
        # end
      end
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

  def check_url_existance
    # binding.pry
    url = Url.where(full_url: urls_params[:full_url]).first
    unless url.nil?
      flash[:message] = "existance"
      return redirect_to url
    end
  end

end
