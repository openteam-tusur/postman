class MessagesController < ApplicationController
  def index
    @messages = MessageSearcher.new(params).results
  end

  def show
    @message = Message.find(params[:id])
  end
end
