# frozen_string_literal: true

class Event < Base
  class InvalidEventTypeError < StandardError; end

  attr_accessor :action, :params

  def initialize(action:, params:)
    @action = action
    @params = params

    super
  end

  def call
    action_service = events[action.to_sym]
    raise InvalidEventTypeError unless action_service

    action_service.new(**params)
  end

  private

  def events
    {
      birthday: Events::EventBirthdayForm,
      business: Events::EventBusinessForm,
      concert: Events::EventConcertForm
    }
  end
end
