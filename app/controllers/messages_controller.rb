class MessagesController < ApplicationController
  before_action :find_message, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @messages = Message.all.order(updated_at: :desc)
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
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
    if @message.update(message_params)
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
