class MessagesController < ApplicationController
  before_action :find_message, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!

  def index
    @messages = Message.all.order(updated_at: :desc)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @message.update
      redirect_to message_path
    else
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    redirect_to root_path
  end

  private

    def find_message
      @message = Message.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_url, flash: { error: "Record not found" }
    end

    def message_params
      params.require(:message).permit(:title, :description)
    end
end
