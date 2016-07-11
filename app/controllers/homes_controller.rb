class HomesController < ApplicationController
  include SlackHandleable

  def index
  end

  def create
    url = params[:url]
    @text = output_message(url)
  end

  def show
  end
end
