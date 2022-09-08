# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  before_action :set_subscriber, only: :update

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscriber.all.order(:created_at)

    total_records = subscribers.count
    limited_subscribers = subscribers.drop(offset).first(limit)

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  ##
  # POST /api/subscribers
  def create
    subscriber = Subscriber.create!(create_params)

    render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
  end

  ##
  # PATCH /api/subscriber/:id
  def update
    @subscriber.update!(update_params.except(:id))

    render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
  end

  private

  def create_params
    params.require(:email)
    params.permit(:email, :name, :subscribed)
  end

  def update_params
    params.permit(:id, :email, :name, :subscribed)
  end

  def set_subscriber
    @subscriber = Subscriber.find(update_params[:id])
  end
end
