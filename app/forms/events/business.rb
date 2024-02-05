# frozen_string_literal: true

module Events
  class Business < Events::Base
    validates :number_of_people, numericality: { greater_than: 5 }
  end
end
