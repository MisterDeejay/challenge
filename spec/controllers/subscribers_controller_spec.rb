# frozen_string_literal: true

require "rails_helper"

RSpec.describe SubscribersController, type: :controller do
  subject! { create(:subscriber, :randomly_named) }

  describe "GET /subscribers" do
    it "returns 200 and a list of subscribers and pagination object" do
      get :index, params: {}, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:subscribers]).not_to be_nil
      expect(json[:pagination]).not_to be_nil
    end

    describe "error cases" do
      describe "when raising a StandardError" do
        before { allow(Subscriber).to receive(:all).and_raise(StandardError) }

        it "returns 404" do
          get :index, format: :json

          expect(response).to have_http_status(:internal_server_error)
          expect(response.content_type).to eq("application/json; charset=utf-8")

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json[:errors].first[:detail]).to eq "Internal Server Error"
        end
      end

      describe "when raising an ArgumentError" do
        before { allow(Subscriber).to receive(:all).and_raise(ArgumentError) }

        it "returns 400" do
          get :index, format: :json

          expect(response).to have_http_status(:bad_request)

          json = JSON.parse(response.body, symbolize_names: true)
          expect(json[:errors].first[:detail]).to eq "Bad request: ArgumentError"
        end
      end
    end
  end

  describe "POST /subscribers" do
    it "returns 201 if it successfully creates a subscriber" do
      post :create, params: {email: Faker::Internet.free_email, name: Faker::Name.name}, format: :json

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:message]).to eq "Subscriber created successfully"
    end

    describe "error cases" do
      it "returns 422 if missing a required parameter" do
        post :create, params: {name: Faker::Name.name}, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:message][:errors].first[:detail]).to eq "Email can't be blank"
      end
    end
  end

  describe "PATCH /subscribers/:id" do
    it "returns 200 if it successfully updates a subscriber" do
      patch :update, params: {id: subject.id, subscribed: false}, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:message]).to eq "Subscriber updated successfully"
    end

    describe "error cases" do
      it "returns 404 if the record cannot be found" do
        patch :update, params: { id: 1, subscribed: nil }, format: :json

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:message][:errors].first[:detail]).to eq "Record not found"
      end

      it "returns 422 if the update params are invalid" do
        patch :update, params: { id: subject.id, subscribed: nil }, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:message][:errors].first[:detail]).to eq "Subscribed must be true or false"
      end
    end
  end
end
