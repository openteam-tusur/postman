class MessagesController < ApplicationController
  def index
    @messages = Message.ordered
  end

  def show
    @message = Message.find(params[:id])
  end
end
