# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      def create
        if event.create
          render json: event, status: :created
        else
          render json: event.errors, status: :unprocessable_entity
        end
      rescue EventFactory::InvalidEventTypeError => e
        render json: { error: e.message }, status: :bad_request
      end

      private

      def event
        @event ||= EventFactory.new(action: event_params[:event_type].to_sym, params: event_params)
      end

      def event_params
        params.require(:event).permit(:title, :description, :event_type, :number_of_people, :special_requests)
      end
    end
  end
end
