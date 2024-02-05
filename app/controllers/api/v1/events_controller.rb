# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      class InvalidEventTypeError < StandardError; end
      INVALID_EVENT_TYPE_MSG = 'Invalid event type'

      def create
        form = build_event_form(event_params)
        return render json: form.errors, status: :unprocessable_entity unless form.valid?

        event = form.create
        render json: event, status: :created
      rescue InvalidEventTypeError => e
        render json: { error: e.message }, status: :bad_request
      end

      private

      def build_event_form(params)
        case params[:event_type]
        when Event.event_types[:birthday]
          Events::Birthday.new(event_params)
        when Event.event_types[:business]
          Events::Business.new(event_params)
        else
          raise InvalidEventTypeError, INVALID_EVENT_TYPE_MSG
        end
      end

      def event_params
        params.require(:event).permit(:title, :description, :event_type, :number_of_people, :special_requests)
      end
    end
  end
end
