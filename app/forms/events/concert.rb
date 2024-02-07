# frozen_string_literal: true

module Events
  class Concert < Events::Base
    validates :number_of_people, numericality: { greater_than: 100 }
  end
end
