module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    before_action :switch_to_public!

    def create
      super
    end

    private

      def switch_to_public!
        Organization.switch_to 'public'
      end
  end
end
