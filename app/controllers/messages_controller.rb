class MessagesController < ApplicationController
  def new
    @message = MessageForm.new(Message.new(message_params))
  end

  def create
    @message = MessageForm.new(Message.new)
    @message.network_event = network_event
    @message.subject = message_params[:message][:subject]
    @message.body = message_params[:message][:body]
    @message.recipient_ids = message_params[:message][:recipient_ids]
    @message.sender = current_user

    if @message.valid? && @message.save
      MessageMailer.message_email(network_event.name, @message.subject, @message.body, mailer_recipients).deliver

      redirect_to network_event_message_path(network_event, @message)
    else
      flash.now[:error] = "Problem creating message"
      render "new"
    end
  end

  def show
    @message = network_event.messages.find(params[:id])
  end

  private

  def mailer_recipients
    @message.model.member_recipients.pluck(:email) << @message.model.adhoc_recipients.pluck(:email)
  end

  def message_params
    params.permit(message: [:subject, :body, recipient_ids: []])
  end

  def network_event
    @network_event ||= NetworkEvent.find(params[:network_event_id])
  end
  helper_method :network_event
end
