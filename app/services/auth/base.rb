# frozen_string_literal: true

module Auth
  class Base < Common::ApplicationService
    attr_accessor :email, :password, :user

    def call
      generate_token if user
    end

    def generate_token
      token = JsonWebToken.encode(uuid: user.uuid)
      # equal to user.update(token: token)
      user.update(token:)
      token
    end
  end
end
