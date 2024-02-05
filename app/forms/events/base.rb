# frozen_string_literal: true

module Events
  class Base
    include ActiveModel::Model

    attr_accessor :title, :description, :event_type, :number_of_people

    validates :title, :event_type, :number_of_people, presence: true

    def attributes
      {
        title:,
        description:,
        event_type:,
        number_of_people:,
        special_requests:
      }
    end
  end
end
